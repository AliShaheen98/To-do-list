//
//  ItemTableViewController.swift
//  To Do List 2
//
//  Created by Ali  on 20/11/2020.
//

import UIKit
import RealmSwift


class ItemTableViewController: UITableViewController {
    var  category:Category? {
        didSet{
            itemArray = category?.items.sorted(byKeyPath: "name")
        }
    }

    let realm = try! Realm()
    var itemArray:Results<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print (Realm.Configuration.defaultConfiguration.fileURL)
        title = category?.name

    }
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        var alertText = UITextField()
        let alert = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            let newItem = Item()
            newItem.name = alertText.text!
            newItem.checked = false
            self.tableView.reloadData()
            try! self.realm.write {
                //self.realm.add(newItem)
                self.category?.items.append(newItem)
            }
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(addAction)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = " Add Item "
            alertText = alertTextField
        }
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)

        cell.textLabel?.text = itemArray[indexPath.row].name

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var item = itemArray[indexPath.row]
        try! realm.write{
        item.checked = !item.checked
        }
        if item.checked{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }else{
                    tableView.cellForRow(at: indexPath)?.accessoryType = .none

        }
}
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = itemArray[indexPath.row]
        try! realm.write {
            realm.delete(item)
        }
        tableView.reloadData()
    }
}

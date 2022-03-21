//
//  ViewController.swift
//  MyToDOList
//
//  Created by Rafał Gęsior on 21/03/2022.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Wstaw kartofle"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Kup prezent dla Iguśki"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Uśmiechnij się"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
    }

    //MARK: - TableView Data Source Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary operator ==> Super sprawa :)
        // value = condition ? valueIfTrue: valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark: .none
        
        return cell
    }
    
    //MARK: - Table View Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
       
                           
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Items

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        // what will happen when user clicks add item button
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let newItem = Item()
        newItem.title = textField.text!
        
        self.itemArray.append(newItem)
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        saveItems()
        
    }
    
    //MARK: - Model Modification Methods
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(self.itemArray)
            let data.write(to: self.dataFilePath!)
        } catch {
            print("Errir encoding item array, \(error)")
            
        }
        self.tableView.reloadData() //bez tego widok tabeli się nie odświeży
    }
    
}


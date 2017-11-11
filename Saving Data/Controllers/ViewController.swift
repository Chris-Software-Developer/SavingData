//
//  ViewController.swift
//  Saving Data
//
//  Created by Christopher Smith on 11/11/17.
//  Copyright © 2017 Christopher Smith. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var contacts = [Contact]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest: NSFetchRequest<Contact> = Contact.fetchRequest()
        
        do{
            let contacts = try PersistenceService.context.fetch(fetchRequest)
            self.contacts = contacts
        } catch {}
        self.tableView.reloadData()
    }
    
    @IBAction func onPlusTapped() {
        let alert = UIAlertController(title: "Add Contact", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Age"
            textField.keyboardType = .numberPad
        }
        
        let action = UIAlertAction(title: "Post", style: .default) { (_) in
            let name = alert.textFields!.first!.text!
            let age = alert.textFields!.last!.text!
            let contact = Contact(context: PersistenceService.context)
            contact.name = name
            contact.age = Int16(age)!
            PersistenceService.saveContext()
            self.contacts.append(contact)
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = contacts[indexPath.row].name
        cell.detailTextLabel?.text = String(contacts[indexPath.row].age)
        return cell
    }
}

//
//  ViewController.swift
//  iOSContact
//
//  Created by Muhammad Noor on 05/09/2018.
//  Copyright © 2018 Muhammad Noor. All rights reserved.
//

import UIKit

class ContactsViewController: UITableViewController {
    
    var twoDimensionalArray = [
        ExpandableNames(isExpanded: true, names: ["Amy", "Bill", "Zack", "Steve", "Jack", "Jill", "Mary"].map{ Contact(name: $0, hasFavorited: false) }),
        ExpandableNames(isExpanded: true, names: ["Carl", "Chris", "Christina", "Cameron"].map{ Contact(name: $0, hasFavorited: false) }),
        ExpandableNames(isExpanded: true, names: ["David", "Dan"].map{ Contact(name: $0, hasFavorited: false) }),
        ExpandableNames(isExpanded: true, names: [Contact(name: "Patrick", hasFavorited: false)]),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .white
        
        
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(ContactsCell.self, forCellReuseIdentifier: ContactsCellReusedIndentified)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionalArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !twoDimensionalArray[section].isExpanded {
            return 0
        }
        return twoDimensionalArray[section].names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactsCellReusedIndentified, for: indexPath) as! ContactsCell
//        cell.link = self
        let contact = twoDimensionalArray[indexPath.section].names[indexPath.row]
        
        cell.textLabel?.text = contact.name
        
        cell.accessoryView?.tintColor = contact.hasFavorited ? UIColor.red : .lightGray
        
//        if showIndexPaths {
//            cell.textLabel?.text = "\(contact.name)   Section:\(indexPath.section) Row:\(indexPath.row)"
//        }
        
        return cell
    }
    
}



struct ExpandableNames {
    var isExpanded: Bool
    var names: [Contact]
}

struct Contact {
    let name: String
    var hasFavorited: Bool
}



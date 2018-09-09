//
//  ViewController.swift
//  iOSContact
//
//  Created by Muhammad Noor on 05/09/2018.
//  Copyright © 2018 Muhammad Noor. All rights reserved.
//

import UIKit

class ContactsViewController: UITableViewController, CreateContactControllerDelegate {
    
    var expandableName: ContactJsonStuff?
    var contacts = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .white
        
        
        navigationItem.title = "Contacts"
        tableView.register(ContactsCell.self, forCellReuseIdentifier: ContactsCellReusedIndentified)
        tableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(handleAddContact))
        
        fetchUser()
    }
    
    
    @objc func handleAddContact() {
        print("Trying to add some contact")
        
        let createContactController = CreateContactController()
        let navController = UINavigationController(rootViewController: createContactController)
        createContactController.delegate = self
        present(navController, animated: true, completion: nil)
    }
    
    func fetchUser()  {
        
        let urlString = "https://sportacuz.id/sandbox/contact"
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else {return}
            print(data)
            
            do {
                let expandableJSON =  try JSONDecoder().decode(ContactJsonStuff.self, from: data)
                self.expandableName = expandableJSON
                DispatchQueue.main.async {
                    print(self.expandableName?.data)
                    self.tableView.reloadData()
                }
                
            } catch let jsonErr {
                print("Error serializing json", jsonErr)
            }
            }.resume()
    }
 
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let exp = expandableName?.data.count else { return 0 }
        print(exp)
        return exp
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (expandableName?.data.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactsCellReusedIndentified, for: indexPath) as! ContactsCell
        
        
        cell.icon.image = #imageLiteral(resourceName: "UserpicIcon")
        guard let firstname = expandableName?.data[indexPath.row].firstname else { return UITableViewCell() }
        guard let lastname = expandableName?.data[indexPath.row].lastname else { return UITableViewCell() }
        cell.title.text = "\(firstname) \(lastname)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = UserContactContainerView()
        destination.contact = expandableName?.data[indexPath.section]
        
        self.navigationController?.pushViewController(destination, animated: true)
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    
    // specify your extension methods here....
    func didAddContact(contact: Contact) {
        // update my tableview somehow
        let row = contacts.index(of: contact)
        
        let reloadIndexPath = IndexPath(row: row!, section: 0)
        tableView.reloadRows(at: [reloadIndexPath], with: .middle)
    }
    
    func EditContact(contact: Contact) {
        contacts.append(contact)
        let newIndexPath = IndexPath(row: contacts.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }

}

struct ContactJsonStuff: Decodable {

    var data: [ContactDataArray]
}


struct ContactDataArray: Codable {
    let id: Int?
    let firstname: String?
    let lastname: String?
//    var isfavorite: Bool = false
    let imageurl: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstname = "firstname"
        case lastname = "lastname"
//        case isfavorite = "isfavorite"
        case imageurl = "imageurl"
    }
}

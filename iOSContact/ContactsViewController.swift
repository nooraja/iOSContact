//
//  ViewController.swift
//  iOSContact
//
//  Created by Muhammad Noor on 05/09/2018.
//  Copyright © 2018 Muhammad Noor. All rights reserved.
//

import UIKit
import CoreData

class ContactsViewController: UITableViewController, CreateContactControllerDelegate, NSFetchedResultsControllerDelegate {
    
//    var expandableName: ContactJsonStuff?
    var contacts = [Contact]()
    
    lazy var fetchResultsController: NSFetchedResultsController<Contact> = {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let request: NSFetchRequest<Contact> = Contact.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "firstname", ascending: true)
        ]
        
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: "firstname", cacheName: nil)
        
        frc.delegate = self
        
        do {
          try frc.performFetch()
            tableView.reloadData()
            
        } catch let err {
            print(err)
        }
        
        return frc
    }()
    
    let cellId = "cellId"
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }
    
    @objc func handleRefresh() {
        Service.shared.downloadContactFromServer()
        self.refreshControl?.endRefreshing()
    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .white
        
        
        navigationItem.title = "Contacts"
        tableView.register(ContactsCell.self, forCellReuseIdentifier: ContactsCellReusedIndentified)
        tableView.dataSource = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        refreshControl.tintColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(handleAddContact))
        
    }
    
    
    @objc func handleAddContact() {
        print("Trying to add some contact")
        
        let createContactController = CreateContactController()
        let navController = UINavigationController(rootViewController: createContactController)
        createContactController.delegate = self
        present(navController, animated: true, completion: nil)
    }
    
    
    @objc private func handleDelete() {
        print("Let's delete a company")
        
        let request: NSFetchRequest<Contact> = Contact.fetchRequest()
        //        request.predicate = NSPredicate(format: "name CONTAINS %@", "Z")
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let contactWithB = try? context.fetch(request)
        
        contactWithB?.forEach { (contact) in
            context.delete(contact)
        }
        
        do {
            try context.save()
        } catch let err {
            print(err)
        }
    }
    
//    func fetchUser()  {
//
//        let urlString = "https://sportacuz.id/sandbox/contact"
//
//        guard let url = URL(string: urlString) else { return }
//        URLSession.shared.dataTask(with: url) { (data, response, err) in
//            guard let data = data else {return}
//            print(data)
//
//            do {
//                let expandableJSON =  try JSONDecoder().decode(ContactJsonStuff.self, from: data)
//                self.expandableName = expandableJSON
//                DispatchQueue.main.async {
//                    print(self.expandableName?.data)
//                    self.tableView.reloadData()
//                }
//
//            } catch let jsonErr {
//                print("Error serializing json", jsonErr)
//            }
//            }.resume()
//    }
 
    override func numberOfSections(in tableView: UITableView) -> Int {
//        guard let exp = expandableName?.data.count else { return 0 }
//        print(exp)
        return fetchResultsController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        return (expandableName?.data.count)!
        return fetchResultsController.sections![section].numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactsCellReusedIndentified, for: indexPath) as! ContactsCell
        
        let contact = fetchResultsController.object(at: indexPath)
        cell.contact = contact
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = UserContactContainerView()
        destination.contact = fetchResultsController.object(at: indexPath)
        
        self.navigationController?.pushViewController(destination, animated: true)
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    
    // specify your extension methods here....
    func didEditContact(contact: Contact) {
        // update my tableview somehow
        guard let row = contacts.index(of: contact) else { return }
        
        // this is error
        let reloadIndexPath = IndexPath(row: row, section: 0)
        tableView.reloadRows(at: [reloadIndexPath], with: .middle)
    }
    
    func didAddContact(contact: Contact) {
        contacts.append(contact)
        let newIndexPath = IndexPath(row: contacts.count - 1, section: 0)
        
        if contacts.count == 0 {
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
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

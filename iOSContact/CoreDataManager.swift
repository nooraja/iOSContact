//
//  CoreDataManager.swift
//  iOSContact
//
//  Created by Muhammad Noor on 09/09/2018.
//  Copyright © 2018 Muhammad Noor. All rights reserved.
//

import CoreData

struct CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ContactMD")
        container.loadPersistentStores(completionHandler: { ( storeDescription, err) in
            if let err = err {
                fatalError("Loading of store failed: \(err)")
            }
        })
        return container
    }()
    
    func fetchContacts() -> [Contact] {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Contact>(entityName: "Contact")
        
        do {
            let complete = try context.fetch(fetchRequest)
            return complete
        } catch let err {
            print("Failet to fetch contact: ", err)
            return []
        }
    }
    
    func resetContacts(completion: () -> ()) {
        let context = persistentContainer.viewContext
        let deleteBatchRequest = NSBatchDeleteRequest(fetchRequest: Contact.fetchRequest())
        
        do {
            try context.execute(deleteBatchRequest)
            completion()
        } catch let err {
            print("Unable to delet batch contact: \(err)")
        }
    }
    
    func createContact(firstName: String, lastName: String, email: String, phoneNumber: String, isFavorite: Int32 = 1,_ imageUrl: String = "") -> (Contact?, Error?) {
        let context = persistentContainer.viewContext
        
        // create a contact
        let contact = NSEntityDescription.insertNewObject(forEntityName: "Contact", into: context) as! Contact
        
        contact.firstname = firstName
        contact.lastname = lastName
        contact.email = email
        contact.phonenumber = phoneNumber
        contact.isfavorite = isFavorite
        contact.imageurl = ""
        
        do {
            try context.save()
            return (contact, nil)
        } catch let err {
            print("Failed to create contact", err)
            return (nil, err)
        }
        
    }
    
}

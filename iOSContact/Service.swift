//
//  Service.swift
//  iOSContact
//
//  Created by Muhammad Noor on 09/09/2018.
//  Copyright © 2018 Muhammad Noor. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct Service {
    static let shared = Service()
    
    let urlString = "https://sportacuz.id/sandbox/contact"
    
    func downloadContactFromServer() {
        print("Attempting to download companies...")
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            print("Finished downloading")
            if let err = err {
                print("Failed to download contacts:", err)
                return
            }
            
            guard let data = data else { return }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                // i'll leave a link in the bottom if you want more details on how JSON Decodable works
                let jsonContacts = try jsonDecoder.decode(JSONContact.self, from: data)
                
                var privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
                
                privateContext = CoreDataManager.shared.persistentContainer.viewContext
                
                jsonContacts.data?.forEach({ (contacts) in
                    print(contacts.lastname)
                    let user = Contact(context: privateContext)
                    user.id = contacts.id!
                    user.firstname = contacts.firstname
                    user.lastname = contacts.lastname
                    user.phonenumber = contacts.phonenumber
                    user.email = contacts.email
                    user.isfavorite = 1
                    user.imageurl = ""
                    
                })
                do {
                    try privateContext.save()
                } catch let err {
                    print("Failed to save companies: " ,err)
                }
            } catch let err {
                print("Failed to decode:", err)
            }
        }.resume() // please do not forget to make this call
    }
}

struct JSONContact: Decodable {
    var message: String?
    var data: [ArrayContact]?
}

class ContactUser: Decodable {
    var data: ArrayContact
}

struct ArrayContact: Decodable {
    let id: Int16?
    let firstname: String?
    let lastname: String?
    let phonenumber: String?
    let email: String?
    var isfavorite: Bool?
    let imageurl: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstname = "firstname"
        case lastname = "lastname"
        case phonenumber = "phonenumber"
        case email = "email"
        case isfavorite = "isfavorite"
        case imageurl = "imageurl"
    }
    
}


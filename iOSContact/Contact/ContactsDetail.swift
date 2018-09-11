//
//  UserContactContainerView.swift
//  iOSContact
//
//  Created by Muhammad Noor on 08/09/2018.
//  Copyright © 2018 Muhammad Noor. All rights reserved.
//

import UIKit


class ContactsDetail: UIViewController {
    
    var contact: Contact? {
        didSet {
            viewHeader.nameLabel.text = (contact?.firstname)! + " " + (contact?.lastname)!
            guard let phone = contactUser?.data.phonenumber else { return  }
            guard let email = contactUser?.data.email else { return }
            
            let attributedPhoneText = NSMutableAttributedString(string: "phone   ", attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 0, alpha: 0.6)])
            
            attributedPhoneText.append(NSAttributedString(string: " \(phone)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]))
            
            mobileText.attributedText = attributedPhoneText
            
            let attributedEmailText = NSMutableAttributedString(string: "email   ", attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 0, alpha: 0.6)])
            
            attributedEmailText.append(NSAttributedString(string: " \(email)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]))
            
            emailText.attributedText = attributedEmailText
        }
    }
    
    var contactUser: ContactUser? {
        didSet {
            guard let phone = contactUser?.data.phonenumber else { return  }
            guard let email = contactUser?.data.email else { return }
            
            let attributedPhoneText = NSMutableAttributedString(string: "phone   ", attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 0, alpha: 0.6)])
            
            attributedPhoneText.append(NSAttributedString(string: " \(phone)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]))
            
            mobileText.attributedText = attributedPhoneText
            
            let attributedEmailText = NSMutableAttributedString(string: "email   ", attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 0, alpha: 0.6)])
            
            attributedEmailText.append(NSAttributedString(string: " \(email)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]))
            
            emailText.attributedText = attributedEmailText
        }
    }
    
    var indexPath: IndexPath? = nil
    
    fileprivate func setupAttributedCaption() {
        
        
    }
    
    lazy var viewHeader: ContactsHeaderDetail =  {
        let vw = ContactsHeaderDetail()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .white
        
        return vw
    }()
    
    lazy var mobileText: UITextView = {
        let txt = UITextView()
        txt.text = "mobile"
        txt.tintColor = UIColor(white: 0, alpha: 0.2)
        txt.font = UIFont.systemFont(ofSize: 14)
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.layer.borderWidth = 2
        txt.layer.borderColor = UIColor.black.cgColor
        
        return txt
    }()
    
    lazy var emailText: UITextView = {
        let txt = UITextView()
        txt.text = "email"
        txt.tintColor = UIColor(white: 0, alpha: 0.2)
        txt.font = UIFont.systemFont(ofSize: 14)
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.layer.borderWidth = 2
        txt.layer.borderColor = UIColor.black.cgColor

        return txt
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(viewHeader)
        view.addSubview(mobileText)
        view.addSubview(emailText)
        
        viewHeader.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 300)
        
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        viewHeader.addSubview(separatorView)
        separatorView.anchor(top: nil, left: viewHeader.leftAnchor, bottom: viewHeader.bottomAnchor, right: viewHeader.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
        mobileText.anchor(top: separatorView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 40)
        
        
        emailText.anchor(top: mobileText.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 40)
        
      
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(handleEdit))
        guard let id = contact?.id else { return }
//        getDetailContactFromServer(id: id)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewHeader.nameLabel.text = (contact?.firstname)! + " " + (contact?.lastname)!
        setupAttributedCaption()

        guard let id = contact?.id else { return }
        getDetailContactFromServer(id: id)
    }
    
    
    func getDetailContactFromServer(id: Int16) {
        
        let urlString = "https://sportacuz.id/sandbox/contact/\(id)"
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, resp, err) in
            print("Finished downloading")
            guard let data = data else {return}
            print(data)
            
            let jsonDecoder = JSONDecoder()
            do {
                let jsonContacts = try jsonDecoder.decode(ContactUser.self, from: data)
                
                print(jsonContacts.data.id)
                self.contactUser?.data = jsonContacts.data
                
            } catch let jsonErr {
                print("Error serializing json", jsonErr)
            }
            }.resume() // please do not forget to make this call
    }
    
    @objc func handleEdit() {
        print("Try to edit this ")
        
        let editContactController = CreateContactController()
        editContactController.contact = contact
        editContactController.indexPathForContact = self.indexPath
        editContactController.firstNameTextField.text = contact?.firstname
        editContactController.lastNameTextField.text = contact?.lastname
        editContactController.mobileTextField.text = contact?.phonenumber
        editContactController.emailTextField.text = contact?.email
        
        
        let navController = UINavigationController(rootViewController: editContactController)
        
        
        present(navController, animated: true, completion: nil)
    }
}

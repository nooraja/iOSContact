//
//  CreateContactController.swift
//  iOSContact
//
//  Created by Muhammad Noor on 09/09/2018.
//  Copyright © 2018 Muhammad Noor. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

protocol CreateContactControllerDelegate {
    func didAddContact(contact: Contact)
    func didEditContact(contact: Contact)
}

class CreateContactController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var contact: Contact? {
        didSet {
            print("noor")
        }
    }
    
    var delegate: CreateContactControllerDelegate?
    var indexPathForContact: IndexPath? = nil
    
    lazy var companyImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "UserpicIcon"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.isUserInteractionEnabled = true
        iv.layer.cornerRadius = iv.frame.width / 2
        iv.clipsToBounds = true
        iv.layer.borderColor = UIColor.darkBlue.cgColor
        iv.layer.borderWidth = 1
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let firstNameLabel: UILabel = {
        let label = UILabel()
        label.text = "First Name"
        // enable autolayout
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let lastNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Last Name"
        // enable autolayout
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let mobileLabel: UILabel = {
        let label = UILabel()
        label.text = "mobile"
        // enable autolayout
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var mobileTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "email"
        // enable autolayout
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    fileprivate func setuUpUI() {
        view.addSubview(companyImageView)
        view.addSubview(firstNameLabel)
        view.addSubview(firstNameTextField)
        view.addSubview(lastNameLabel)
        view.addSubview(lastNameTextField)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(mobileLabel)
        view.addSubview(mobileTextField)
        
        companyImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
        companyImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        firstNameLabel.anchor(top: companyImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 100, height: 50)
        
        firstNameTextField.anchor(top: firstNameLabel.topAnchor, left: firstNameLabel.rightAnchor, bottom: firstNameLabel.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        lastNameLabel.anchor(top: firstNameLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 100, height: 50)
        
        lastNameTextField.anchor(top: lastNameLabel.topAnchor, left: lastNameLabel.rightAnchor, bottom: lastNameLabel.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        mobileLabel.anchor(top: lastNameLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 100, height: 50)
        
        mobileTextField.anchor(top: mobileLabel.topAnchor, left: mobileLabel.rightAnchor, bottom: mobileLabel.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        emailLabel.anchor(top: mobileLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 100, height: 50)
        
        emailTextField.anchor(top: emailLabel.topAnchor, left: emailLabel.rightAnchor, bottom: emailLabel.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelModal))
        
        setuUpUI()
    }
    
    @objc func handleCancelModal() {
        dismiss(animated: true, completion: nil )
    }
    
    @objc private func handleSave() {
        if contact == nil {
            createContact()
        } else {
            saveContactChanges()
        }
    }
    
    private func createContact()  {
        print("Trying to save contact...")
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        // insert to CoreData
        let contact = NSEntityDescription.insertNewObject(forEntityName: "Contact", into: context)
        
        contact.setValue(firstNameTextField.text , forKey: "firstname")
        contact.setValue(lastNameTextField.text , forKey: "lastname")
        contact.setValue(mobileTextField.text, forKey: "phonenumber")
        contact.setValue(emailTextField.text, forKey: "email")
        contact.setValue("", forKey: "imageurl")
        contact.setValue(false, forKey: "isfavorite")
        
        guard let firstname = firstNameTextField.text else { return }
        guard let lastname = lastNameTextField.text else { return }
        guard let phone = mobileTextField.text else { return }
        guard let email = emailTextField.text else { return }
        
        let tuple = CoreDataManager.shared.createContact(firstName: firstname, lastName: lastname, email: email, phoneNumber: phone)
        // perform the save
        do {
            try context.save()
            
            dismiss(animated: true) {
                self.delegate?.didAddContact(contact: tuple.0!)
                self.handleUpload()
            }
        } catch let saveErr {
            print("Failed to save Company :", saveErr)
        }
    }
    
    func handleUpload()  {
        print("Trying to add data to server")
        guard let firstname = firstNameTextField.text else { return }
        guard let lastname = lastNameTextField.text else { return }
        guard let phone = mobileTextField.text else { return }
        guard let email = emailTextField.text else { return }
        let headers: HTTPHeaders = ["Content-type": "application/json"]
        
        let param: Parameters = [
            "firstname"     : firstname,
            "lastname"      : lastname,
            "email"         : email,
            "isfavorite"    : 1,
            "phonenumber"   : phone
        ]
        
        guard let urlString = URL(string: "https://sportacuz.id/sandbox/contact") else { return }
        
        
        Alamofire.upload(multipartFormData: { multipart in

            for (key, value) in param {
                if value is String {
                    multipart.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                } else if value is Int {
                    multipart.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                }
            }
            
        }, to: urlString, method: .post, headers: headers) { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    debugPrint(response)
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }

    private func saveContactChanges() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        contact?.firstname = firstNameTextField.text
        contact?.lastname = lastNameTextField.text
        contact?.phonenumber = mobileTextField.text
        contact?.email = emailTextField.text
        contact?.isfavorite = 1
        contact?.imageurl = ""
        
        do {
            try context.save()
            
            // save succeeded
            dismiss(animated: true) {
                self.delegate?.didEditContact(contact: self.contact!)
            }
        } catch let saveErr {
            print("Failed to save company changes: ", saveErr )
        }
    }
    
    
    
}

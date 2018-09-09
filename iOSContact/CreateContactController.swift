//
//  CreateContactController.swift
//  iOSContact
//
//  Created by Muhammad Noor on 09/09/2018.
//  Copyright © 2018 Muhammad Noor. All rights reserved.
//

import UIKit
import CoreData

protocol CreateContactControllerDelegate {
    func didAddContact(contact: Contact)
    func EditContact(contact: Contact)
}

class CreateContactController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var contact: Contact? {
        didSet {
            print("noor")
        }
    }
    
    var delegate: CreateContactControllerDelegate?
    
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
    
    let firstNameTextField: UITextField = {
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
    
    let lastNameTextField: UITextField = {
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
    
    let mobileTextField: UITextField = {
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
    
    let emailTextField: UITextField = {
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
        
        setuUpUI()
    }
    
    
    
}

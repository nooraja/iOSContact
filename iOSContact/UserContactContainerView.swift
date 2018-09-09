//
//  UserContactContainerView.swift
//  iOSContact
//
//  Created by Muhammad Noor on 08/09/2018.
//  Copyright © 2018 Muhammad Noor. All rights reserved.
//

import UIKit


class UserContactContainerView: UIViewController {
    
    var contact: ContactDataArray? {
        didSet {
            viewHeader.nameLabel.text = (contact?.firstname)! + " " + (contact?.lastname)!
            
            setupAttributedCaption()
        }
    }
    
    fileprivate func setupAttributedCaption() {
        
        guard let phone = contact?.lastname else { return  }
        
        let attributedText = NSMutableAttributedString(string: "email    ", attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 0, alpha: 0.6)])
        
        attributedText.append(NSAttributedString(string: " \(contact?.firstname ?? "")", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]))
        
        emailText.attributedText = attributedText
    }
    
    let viewHeader: UserHeaderContactView =  {
        let vw = UserHeaderContactView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .white
        
        return vw
    }()
    
    let mobileText: UITextView = {
        let txt = UITextView()
        txt.text = "mobile"
        txt.tintColor = UIColor(white: 0, alpha: 0.2)
        txt.font = UIFont.systemFont(ofSize: 14)
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.layer.borderWidth = 2
        txt.layer.borderColor = UIColor.black.cgColor
        
        return txt
    }()
    
    let emailText: UITextView = {
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
        
      
        
        
    }
}

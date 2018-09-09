//
//  UserHeaderContactView.swift
//  iOSContact
//
//  Created by Muhammad Noor on 09/09/2018.
//  Copyright © 2018 Muhammad Noor. All rights reserved.
//

import UIKit

class UserHeaderContactView: UIView {
    
    lazy var profileImageView: UIImageView = {
        let profileImageView = UIImageView()
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.image = #imageLiteral(resourceName: "UserpicIcon")
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.cornerRadius = 48
        profileImageView.isUserInteractionEnabled = true
        
        return profileImageView
    }()
    
    let nameLabel: UILabel = {
        let addPhotoLabel = UILabel()
        addPhotoLabel.translatesAutoresizingMaskIntoConstraints = false
        addPhotoLabel.text = "name"
        addPhotoLabel.numberOfLines = 2
        addPhotoLabel.textColor = .black
        addPhotoLabel.textAlignment = .center
        
        return addPhotoLabel
    }()
    
    let buttonMessage: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "message"), for: .normal)
        button.backgroundColor = UIColor(red: 0.314, green: 0.890, blue: 0.761, alpha: 1)
        button.clipsToBounds = true
        
        return button
    }()
    
    let buttonCall: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "message"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 0.314, green: 0.890, blue: 0.761, alpha: 1)
        button.clipsToBounds = true
        
        return button
    }()
    
    let buttonEmail: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "message"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 0.314, green: 0.890, blue: 0.761, alpha: 1)
        button.clipsToBounds = true
        
        return button
    }()
    
    let buttonFavorite: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "message"), for: .normal)
        button.backgroundColor = UIColor(red: 0.314, green: 0.890, blue: 0.761, alpha: 1)
        button.clipsToBounds = true
        
        return button
    }()
    
    let textCall: UILabel = {
        let txt = UILabel()
        txt.text = "call"
        txt.textAlignment = .center
        txt.textColor = UIColor.black
        txt.font = UIFont.systemFont(ofSize: 14)
        
        return txt
    }()
    
    let textMessage: UILabel = {
        let txt = UILabel()
        txt.text = "message"
        txt.textAlignment = .center
        txt.textColor = UIColor.black
        txt.font = UIFont.systemFont(ofSize: 14)
        
        return txt
    }()
    
    let textEmail: UILabel = {
        let txt = UILabel()
        txt.text = "call"
        txt.textAlignment = .center
        txt.textColor = UIColor.black
        txt.font = UIFont.systemFont(ofSize: 14)
        
        return txt
    }()
    
    let textFavorite: UILabel = {
        let txt = UILabel()
        txt.text = "favorite"
        txt.textAlignment = .center
        txt.textColor = UIColor.black
        txt.font = UIFont.systemFont(ofSize: 14)
        
        return txt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        let stackView = UIStackView(arrangedSubviews: [buttonMessage, buttonCall, buttonEmail, buttonFavorite])
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.backgroundColor = .purple
        stackView.layer.borderColor = UIColor.white.cgColor
        stackView.layer.borderWidth = 1
        
        let messageStackView = UIStackView(arrangedSubviews: [textCall, textEmail, textMessage, textFavorite])
        messageStackView.distribution = .fillEqually
        messageStackView.spacing = 10
        messageStackView.axis = .horizontal
        messageStackView.backgroundColor = .purple
        
        
        self.backgroundColor = .white
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(stackView)
        addSubview(messageStackView)
        
        
        profileImageView.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
        profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        nameLabel.anchor(top: profileImageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 50)
        nameLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor).isActive = true
        
        stackView.anchor(top: nameLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: self.frame.width, height: 50)
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        messageStackView.anchor(top: stackView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: self.frame.width, height: 50)
        messageStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        messageStackView.layer.borderColor = UIColor.white.cgColor
        messageStackView.layer.borderWidth = 1
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

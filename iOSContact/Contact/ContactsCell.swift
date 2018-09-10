//
//  ContactsCell.swift
//  iOSContact
//
//  Created by Muhammad Noor on 06/09/2018.
//  Copyright © 2018 Muhammad Noor. All rights reserved.
//

import UIKit

let ContactsCellReusedIndentified = NSStringFromClass(ContactsCell.classForCoder())

class ContactsCell: UITableViewCell {
    
    var contact: Contact? {
        didSet {
            title.text = contact?.firstname
        }
    }
    
    var icon: UIImageView = {
        var icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFill
        icon.layer.cornerRadius = 20
        icon.layer.masksToBounds = true
        
        return icon
    }()
    
    
    let title: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.semibold)
        lbl.textColor = .black
        
        return lbl
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        title.backgroundColor = backgroundColor
        icon.backgroundColor = backgroundColor
        
        
//        let starButton = UIButton(type: .system)
//        starButton.setImage(#imageLiteral(resourceName: "fav_star"), for: .normal)
//        starButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)


        contentView.addSubview(icon)
        icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 46).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        
        
        contentView.addSubview(title)
        title.centerYAnchor.constraint(equalTo: icon.centerYAnchor, constant: 0).isActive = true
        title.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 15).isActive = true
        title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        title.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = ""
        icon.image = #imageLiteral(resourceName: "UserpicIcon")
    }
    
}

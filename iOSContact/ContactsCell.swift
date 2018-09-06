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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .blue
        
        let starButton = UIButton(type: .system)
        starButton.setImage(#imageLiteral(resourceName: "fav_star"), for: .normal)
        starButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        starButton.tintColor = .red
//        starButton.addTarget(self, action: #selector(handleMarkAsFavorite), for: .touchUpInside)
        
        accessoryView = starButton
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

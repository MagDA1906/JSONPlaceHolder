//
//  UsersTableViewCell.swift
//  JSONPlaceHolder
//
//  Created by Денис Магильницкий on 27/02/2020.
//  Copyright © 2020 Денис Магильницкий. All rights reserved.
//

import UIKit

class UsersTableViewCell: UITableViewCell {
    
    // MARK: - Static Properties
    
    static let reuseId = String(describing: UsersTableViewCell.self)
    
    let userNameLabel: UILabel = {
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .disclosureIndicator
        
        addSubview(userNameLabel)

        // userNameLabel constraints
        userNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        userNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        userNameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

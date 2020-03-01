//
//  AlbumsTableViewCell.swift
//  JSONPlaceHolder
//
//  Created by Денис Магильницкий on 29/02/2020.
//  Copyright © 2020 Денис Магильницкий. All rights reserved.
//

import UIKit

class AlbumsTableViewCell: UITableViewCell {
    
    // MARK: - Static Properties
    
    static let reuseId = String(describing: AlbumsTableViewCell.self)
    
    let albumTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .disclosureIndicator
        
        addSubview(albumTitleLabel)
        
        // userNameLabel constraints
        albumTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        albumTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        albumTitleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        albumTitleLabel.text = ""
    }
}

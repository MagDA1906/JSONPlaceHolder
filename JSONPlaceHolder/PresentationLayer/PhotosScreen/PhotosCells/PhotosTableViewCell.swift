//
//  PhotosTableViewCell.swift
//  JSONPlaceHolder
//
//  Created by Денис Магильницкий on 01/03/2020.
//  Copyright © 2020 Денис Магильницкий. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    // MARK: - Static Properties
    
    static let nibName = String(describing: PhotosTableViewCell.self)
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var photoTitleLable: UILabel!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    @IBOutlet private weak var backView: UIView!
    
    // MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        photoImageView.image = nil
        photoTitleLable.text = ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureSelf()
    }
    
}

// MARK: - Public Functions

extension PhotosTableViewCell {
    
    func configureSelfUsingModel(_ model: Photos) {
        spinner.startAnimating()
        photoTitleLable.text = model.title
        
        let url = model.url
        
        ServiceAPI.shared.getImageBy(model.url as NSString) { (image) in
            DispatchQueue.main.async {
                if url == model.url {
                    self.photoImageView.image = image
                    self.spinner.stopAnimating()
                }
            }
        }
    }
}

// MARK: - Private Functions

private extension PhotosTableViewCell {
    
    func configureSelf() {
        
        self.backgroundColor = UIColor.clear
        self.contentView.frame = contentView.frame.insetBy(dx: 4, dy: 4)
        self.selectionStyle = UITableViewCellSelectionStyle.none
        
        configureBackView()
        configureTitleLabel()
        configureShadowView()
    }
    
    func configureBackView() {
        backView.layer.cornerRadius = 8
        backView.layer.masksToBounds = true
    }
    
    func configureTitleLabel() {
        photoTitleLable.numberOfLines = 0
    }
    
    func configureShadowView() {
        self.layer.shadowOpacity = 0.18
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = false
    }
}

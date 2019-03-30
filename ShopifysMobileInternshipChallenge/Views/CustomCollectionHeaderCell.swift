//
//  CustomCollectionHeaderCell.swift
//  ShopifysMobileInternshipChallenge
//
//  Created by Uchenna  Aguocha on 3/29/19.
//  Copyright © 2019 Uchenna  Aguocha. All rights reserved.
//

import UIKit

class CustomCollectionHeaderCell: UITableViewCell {
    
    // MARK:- Properties
    
    static let cellId = "CustomCollectionHeaderCellId"
    
    // MARK:- UI Elements
    
    var collectionImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.layer.cornerRadius = 6
        return view
    }()
    
    let productNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 22)
        label.textColor = CustomColor.whiteWalker
        return label
    }()
    
    // MARK:- Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.contentView.backgroundColor = CustomColor.blackishPurple
        setupAutoLayout()
    }
    
    func setupAutoLayout() {
        contentView.addSubview(collectionImageView)

        collectionImageView.anchor(top: contentView.topAnchor, right: contentView.rightAnchor, bottom: contentView.bottomAnchor, left: contentView.leftAnchor, topPadding: 0, rightPadding: 0, bottomPadding: 10, leftPadding: 0, height: 0, width: 0)
        
        collectionImageView.addSubview(productNameLabel)
        productNameLabel.anchor(top: nil, right: collectionImageView.rightAnchor, bottom: collectionImageView.bottomAnchor, left: collectionImageView.leftAnchor, topPadding: 0, rightPadding: 20, bottomPadding: 10, leftPadding: 20, height: 30, width: 0)
    }
    
    func configure(with customCollection: CustomCollection) {
        
        DispatchQueue.main.async {
            guard let url = URL(string: customCollection.image) else { return }
            self.collectionImageView.kf.indicatorType = .activity
            self.collectionImageView.kf.setImage(with: url)
        }
        
        productNameLabel.text = customCollection.title
    }
    
}

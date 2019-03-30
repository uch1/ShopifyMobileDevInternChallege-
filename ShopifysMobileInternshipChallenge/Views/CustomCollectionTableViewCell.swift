//
//  CustomCollectionTableViewCell.swift
//  ShopifysMobileInternshipChallenge
//
//  Created by Uchenna  Aguocha on 3/28/19.
//  Copyright © 2019 Uchenna  Aguocha. All rights reserved.
//

import UIKit
import Kingfisher

struct CustomColor {
    static let blackishPurple = UIColor(red: 7/255, green: 7/255, blue: 23/255, alpha: 1)
    static let grayishPurple = UIColor(red: 30/255, green: 30/255, blue: 45/255, alpha: 1)
    static let whiteWalker = UIColor(red: 246/255, green: 248/255, blue: 252/255, alpha: 1)
    static let purplishWhite = UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 0.18)
}

class CustomCollectionTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let cellId = "CustomCollectionTableViewCellId"
    
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
        label.font = UIFont(name: "AvenirNext-Bold", size: 17)
        label.textColor = CustomColor.whiteWalker
        return label
    }()
    
    let collectionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        label.textColor = CustomColor.whiteWalker
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = CustomColor.grayishPurple
        view.layer.cornerRadius = 6
        view.layer.shadowColor = CustomColor.purplishWhite.cgColor
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowOpacity = 0.25
        view.layer.shadowRadius = 6
        return view
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
    
    
    // MARK:- Methods
    
    private func setupAutoLayout() {
        
        let collectionDetailStackView = UIStackView(arrangedSubviews: [productNameLabel, collectionTitleLabel])
        collectionDetailStackView.axis = .vertical
        collectionDetailStackView.alignment = .leading
        collectionDetailStackView.distribution = .fillProportionally
        collectionDetailStackView.spacing = 10
        
        
        contentView.addSubview(containerView)
        
        containerView.anchor(
            top: contentView.topAnchor,
            right: contentView.rightAnchor,
            bottom: contentView.bottomAnchor,
            left: contentView.leftAnchor,
            topPadding: 10,
            rightPadding: 16,
            bottomPadding: 10,
            leftPadding: 16,
            height: 0,
            width: 0)
        
        containerView.addSubviews(views: collectionImageView, collectionDetailStackView)
        
        collectionImageView.anchor(top: containerView.topAnchor, right: nil, bottom: containerView.bottomAnchor, left: containerView.leftAnchor, topPadding: 10, rightPadding: 0, bottomPadding: 10, leftPadding: 10, height: 0, width: 80)
        
        collectionDetailStackView.anchor(top: containerView.topAnchor, right: containerView.rightAnchor, bottom: containerView.bottomAnchor, left: collectionImageView.rightAnchor, topPadding: 10, rightPadding: 10, bottomPadding: 10, leftPadding: 16, height: 0, width: 0)
    }
    
    
    func configure(with customCollection: CustomCollection) {
        
        DispatchQueue.main.async {
            guard let url = URL(string: customCollection.image) else { return }
            self.collectionImageView.kf.indicatorType = .activity
            self.collectionImageView.kf.setImage(with: url)
        }
        
        productNameLabel.text = customCollection.title
        collectionTitleLabel.text = customCollection.body
        
    }
}

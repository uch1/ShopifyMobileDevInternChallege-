//
//  ProductTableViewCell.swift
//  ShopifysMobileInternshipChallenge
//
//  Created by Uchenna  Aguocha on 3/29/19.
//  Copyright © 2019 Uchenna  Aguocha. All rights reserved.
//

import UIKit
import Kingfisher

class ProductTableViewCell: UITableViewCell {
    
    // MARK:- Properties
    
    static let cellId = "ProductTableViewCellId"
    
    // MARK:- UI Elements
    
    var productImageView: UIImageView = {
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
    
    let productTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 14)
        label.textColor = CustomColor.whiteWalker
        return label
    }()
    
    let variantsInventoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 14)
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
    
    private let productBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 38/255, alpha: 0.32)
        return view
    }()
    
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
    
    private func setupAutoLayout() {
        contentView.addSubview(containerView)
        
        containerView.anchor(top: contentView.topAnchor, right: contentView.rightAnchor, bottom: contentView.bottomAnchor, left: contentView.leftAnchor, topPadding: 20, rightPadding: 20, bottomPadding: 20, leftPadding: 20, height: 0, width: 0)
        
        containerView.addSubview(productImageView)

        productImageView.anchor(top: containerView.topAnchor, right: containerView.rightAnchor, bottom: containerView.bottomAnchor, left: containerView.leftAnchor)
        
        productImageView.addSubview(productBackgroundView)
        productBackgroundView.anchor(top: productImageView.topAnchor, right: productImageView.rightAnchor, bottom: productImageView.bottomAnchor, left: productImageView.leftAnchor)
        
        let productInfoStackView = UIStackView(arrangedSubviews: [productNameLabel, productTitleLabel, variantsInventoryLabel])
        productInfoStackView.axis = .vertical
        productInfoStackView.alignment = .leading
        productInfoStackView.distribution = .fillProportionally
        productInfoStackView.spacing = 0
        
        productBackgroundView.addSubview(productInfoStackView)
        productInfoStackView.anchor(top: nil, right: productBackgroundView.rightAnchor, bottom: productBackgroundView.bottomAnchor, left: productBackgroundView.leftAnchor, topPadding: 0, rightPadding: 10, bottomPadding: 10, leftPadding: 10, height: 80, width: 0)
        
        
        
        
        
    }
    
    func configure(with product: Product) {
        
        DispatchQueue.main.async {
            guard let url = URL(string: product.image) else { return }
            self.productImageView.kf.indicatorType = .activity
            self.productImageView.kf.setImage(with: url)
        }
        
        productNameLabel.text = product.title
        productTitleLabel.text = product.body
        variantsInventoryLabel.text = "\(product.variantsTotal) variants available"
        
    }
    
}

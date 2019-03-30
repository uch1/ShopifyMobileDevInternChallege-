//
//  ProductsListController.swift
//  ShopifysMobileInternshipChallenge
//
//  Created by Uchenna  Aguocha on 3/29/19.
//  Copyright © 2019 Uchenna  Aguocha. All rights reserved.
//

import Foundation
import UIKit

class ProductsListController: UITableViewController {
    
    // MARK:- Properties
    
    var productsIds: String?
    
    var customCollection: CustomCollection?
    var products = [Product]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    // MARK:- View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        navigationItem.title = "Collects"
        setupTableView()
        
        NetworkingMangager.fetch(httpMethod: .get, resource: .products(id: productsIds ?? "0")) { (data) in
            
            let productList = try? JSONDecoder().decode(ProductList.self, from: data)
            self.products = productList?.products ?? []
        }
    }

    // MARK:- Methods
    
    func setupTableView() {
        tableView.backgroundColor = CustomColor.blackishPurple
        tableView.register(CustomCollectionHeaderCell.self, forCellReuseIdentifier: CustomCollectionHeaderCell.cellId)
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.cellId)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: CustomCollectionHeaderCell.cellId, for: indexPath) as! CustomCollectionHeaderCell
            guard let collection = customCollection else { return UITableViewCell()}
            headerCell.configure(with: collection)
            return headerCell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.cellId, for: indexPath) as! ProductTableViewCell
            
            cell.configure(with: products[indexPath.row])
            
            return cell
            
        default: return UITableViewCell()
        }
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return products.count
        default: return 0 
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height
        return screenHeight * 0.40
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 0: return nil
        case 1:
            let screenSize: CGRect = UIScreen.main.bounds
            let screenWidth = screenSize.width
            
            let headerContainerView = UIView()
            headerContainerView.frame = CGRect(x: 0, y: 0, width: screenWidth - 10, height: 50)
            headerContainerView.backgroundColor = CustomColor.blackishPurple
            
            let productHeaderLabel = UILabel()
            productHeaderLabel.frame = CGRect(x: 20, y: 0, width: screenWidth - 10, height: 31)
            productHeaderLabel.text = "Product List"
            productHeaderLabel.font = UIFont(name: "AvenirNext-Bold", size: 23)
            productHeaderLabel.textColor = CustomColor.whiteWalker
            productHeaderLabel.textAlignment = .left
            
            headerContainerView.addSubview(productHeaderLabel)
            
            return headerContainerView
            
            
        default: return UILabel()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0: return 0
        case 1: return 30
        default: return 0
        }
    }
    
}

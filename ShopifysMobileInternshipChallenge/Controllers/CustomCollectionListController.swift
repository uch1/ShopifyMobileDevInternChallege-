//
//  CollectionListTableViewController.swift
//  ShopifysMobileInternshipChallenge
//
//  Created by Uchenna  Aguocha on 3/28/19.
//  Copyright © 2019 Uchenna  Aguocha. All rights reserved.
//

import UIKit

class CustomCollectionListController: UITableViewController {
    
    // MARK:- Properties
    var customCollections = [CustomCollection]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var collects = [Collect]() {
        didSet {
            
        }
    }
    
    // MARK:- View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = CustomColor.whiteWalker
        setupTableView()
        navigationItem.title = "Collections"
        
        NetworkingMangager.fetch(httpMethod: .get, resource: .customCollections) { (data) in
            let decodedData = try? JSONDecoder().decode(Collections.self, from: data) 
            self.customCollections = decodedData?.custom_collections ?? []
            
        }
        
        
    }
    
    // MARK:- Methods
    
    func setupTableView() {
        tableView.backgroundColor = CustomColor.blackishPurple
        tableView.register(CustomCollectionTableViewCell.self, forCellReuseIdentifier: CustomCollectionTableViewCell.cellId)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func fetchCollects(id: String, completion: @escaping ([Collect]) -> Void) {
        NetworkingMangager.fetch(httpMethod: .get, resource: .collects(id: id)) { (data) in
            
            let productCollect = try? JSONDecoder().decode(ProductCollect.self, from: data)
            self.collects = productCollect?.collects ?? []
            
            completion(self.collects)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCollectionTableViewCell.cellId, for: indexPath) as! CustomCollectionTableViewCell
        
        cell.configure(with: customCollections[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customCollections.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = String(customCollections[indexPath.row].id)
        
        fetchCollects(id: id) { (collects) in
            let productIds = collects.map { String($0.productId) }.joined(separator: ",")
            
            DispatchQueue.main.async {
                let productsListController = ProductsListController()
                productsListController.productsIds = productIds
                productsListController.customCollection = self.customCollections[indexPath.row]
                self.navigationController?.pushViewController(productsListController, animated: true)
            }
        }
    }
}

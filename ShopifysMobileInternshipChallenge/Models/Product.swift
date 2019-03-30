//
//  Product.swift
//  ShopifysMobileInternshipChallenge
//
//  Created by Uchenna  Aguocha on 3/28/19.
//  Copyright © 2019 Uchenna  Aguocha. All rights reserved.
//

import Foundation

struct ProductList: Decodable {
    let products: [Product]
}

struct Product: Decodable {
    
    // MARK:- Properties
    
    let title: String
    let body: String
    let image: String
    let vendor: String
    let variantsTotal: Int
    
    // MARK:- Coding Key
    
    enum EntryKey: String, CodingKey {
    // Top-level Coding Keys
        case title
        case vendor
        case body = "body_html"
        case image
        case variants
    }
    
    enum ImageKey: String, CodingKey {
        case src
    }
    
    init(from decoder: Decoder) throws {
        let mainContainer = try decoder.container(keyedBy: EntryKey.self)
        title = try mainContainer.decodeIfPresent(String.self, forKey: .title) ?? ""
        body = try mainContainer.decodeIfPresent(String.self, forKey: .body) ?? ""
        vendor = try mainContainer.decodeIfPresent(String.self, forKey: .vendor) ?? ""
        
        let imageContainer = try mainContainer.nestedContainer(keyedBy: ImageKey.self, forKey: .image)
        
        image = try imageContainer.decodeIfPresent(String.self, forKey: .src) ?? ""
        
        let variantsContainer = try mainContainer.decodeIfPresent([Variant].self, forKey: .variants)

        
        variantsTotal = variantsContainer?.reduce(0, { (result: Int, variant) -> Int in
            result + variant.inventoryQuantity
        }) ?? 0
        
    }
    
}

extension Product {
    
    // Nest Variant inside of Product to mirror the product.json structure
    struct Variant: Decodable {
        
        // MARK:- Properties
        
        let inventoryQuantity: Int
        
        // MARK:- Coding Key
        
        enum EntryKey: String, CodingKey {
            case inventoryQuantity = "inventory_quantity"
        }
        
        // MARK:- Initializer
        
        init(from decoder: Decoder) throws {
            let mainContainer = try decoder.container(keyedBy: EntryKey.self)
            inventoryQuantity = try mainContainer.decodeIfPresent(Int.self, forKey: .inventoryQuantity) ?? 0
        }
        
    }
    
}

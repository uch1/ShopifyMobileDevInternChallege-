//
//  Collect.swift
//  ShopifysMobileInternshipChallenge
//
//  Created by Uchenna  Aguocha on 3/28/19.
//  Copyright © 2019 Uchenna  Aguocha. All rights reserved.
//

import Foundation

struct ProductCollect: Decodable {
    let collects: [Collect]
}

struct Collect: Decodable {
    let productId: Int
    
    enum EntryKey: String, CodingKey {
        case productId = "product_id"
    }
    
    init(from decoder: Decoder) throws {
        let entryContainer = try decoder.container(keyedBy: EntryKey.self)
        productId = try entryContainer.decodeIfPresent(Int.self, forKey: .productId) ?? 0
    }
}

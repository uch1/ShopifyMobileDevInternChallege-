//
//  CustomCollection.swift
//  ShopifysMobileInternshipChallenge
//
//  Created by Uchenna  Aguocha on 3/28/19.
//  Copyright © 2019 Uchenna  Aguocha. All rights reserved.
//

import Foundation

struct Collections: Decodable {
    
    // MARK:- Properties
    
    let custom_collections: [CustomCollection]

}


struct CustomCollection: Decodable  {
    
    // MARK:- Properties
    
    let id: Int
    let title: String
    let image: String
    let body: String
    
    // MARK:- Coding Key
    
    enum EntryKey: String, CodingKey {
    // Top-level Entry Keys
        case id
        case title
        case image
        case body = "body_html"
    }
    
    // Second-level Keys
    enum ImageKey: String, CodingKey {
        case src
    }
    
    
    // MARK:- Initializer
    
    init(from decoder: Decoder) throws {
        let entryContainer = try decoder.container(keyedBy: EntryKey.self)
        
        id = try entryContainer.decode(Int.self, forKey: .id)
        title = try entryContainer.decodeIfPresent(String.self, forKey: .title) ?? ""
        body = try entryContainer.decodeIfPresent(String.self, forKey: .body) ?? ""
        
        let imageContainer = try entryContainer.nestedContainer(keyedBy: ImageKey.self, forKey: .image)
        image = try imageContainer.decodeIfPresent(String.self, forKey: .src) ?? ""
    }
    
}

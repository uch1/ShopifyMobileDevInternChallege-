//
//  Route.swift
//  ShopifysMobileInternshipChallenge
//
//  Created by Uchenna  Aguocha on 3/28/19.
//  Copyright © 2019 Uchenna  Aguocha. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

enum Resource {
    
    case customCollections
    case collects(id: String)
    case products(id: String)
    
    func path() -> String {
        switch self {
        case .customCollections:
            return "https://shopicruit.myshopify.com/admin/custom_collections.json"
        case .collects:
            return "https://shopicruit.myshopify.com/admin/collects.json"
        case .products:
            return "https://shopicruit.myshopify.com/admin/products.json"
        }
    }
    
    func parameters() -> [String: String] {
        switch self {
        case .customCollections:
            return ["access_token": "c32313df0d0ef512ca64d5b336a0d7c6"]
            
        case .collects(let id):
            return ["collection_id": id,
                    "access_token": "c32313df0d0ef512ca64d5b336a0d7c6"
                   ]
            
        case .products(let id):
            return [ "ids": id,
                     "access_token": "c32313df0d0ef512ca64d5b336a0d7c6"
                    ]
        }
    }
}


protocol URLQueryParameterStringConvertible {
    var queryParameters: String { get }
}

extension Dictionary: URLQueryParameterStringConvertible {
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@",
                              String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                              String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                              )
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
    
    
}

extension URL {
    func appendingQueryParameters(_ parameters: Dictionary<String, String>) -> URL {
        let url = String(format: "%@?%@", self.absoluteString, parameters.queryParameters)
        return URL(string: url)!
    }
}

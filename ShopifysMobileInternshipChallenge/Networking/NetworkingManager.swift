//
//  NetworkingManager.swift
//  ShopifysMobileInternshipChallenge
//
//  Created by Uchenna  Aguocha on 3/28/19.
//  Copyright © 2019 Uchenna  Aguocha. All rights reserved.
//

import Foundation

class NetworkingMangager {
    
    static func fetch(httpMethod: HTTPMethod, resource: Resource, completion: @escaping (Data) -> Void) {
        
        guard let url = URL(string: resource.path())?.appendingQueryParameters(resource.parameters()) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else { return }
            completion(data)
        }
        task.resume()
    }
    
    
}

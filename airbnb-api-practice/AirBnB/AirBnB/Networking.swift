//
//  Networking.swift
//  AirBnB
//
//  Created by Andrew Tsukuda on 10/27/17.
//  Copyright © 2017 Andrew Tsukuda. All rights reserved.
//

import Foundation

class Networking {
    let session = URLSession.shared
    let baseURL = URL(string: "https://api.airbnb.com/v2/search_results?key=915pw2pnf4h1aiguhph5gc5b2")!
    
    func getListing(completion: @escaping ([Listing]) -> Void) {
        
        let request = URLRequest(url: baseURL)
        
        session.dataTask(with: request) { (data, resp, err) in
            if let data = data {
                let listingContainer = try? JSONDecoder().decode(ListingContainer.self, from: data)
                
                if let listings = listingContainer?.search_results {
                    completion(listings)
                    dump(listings)
                    print("number of listings: \(listings.count)")
                } else {
                    print("Response: \(String(describing: resp))")
                }
                
            }
            }.resume()
    }
}



//
//  Listing.swift
//  AirBnB
//
//  Created by Andrew Tsukuda on 10/27/17.
//  Copyright © 2017 Andrew Tsukuda. All rights reserved.
//

import Foundation

struct Listing {
    let city: String
    let bedroomCount: Int
    let bathroomCount: Float
    let localizedCurrency: String
    let localizedNightlyPrice: Int
    
    init(city: String, bedroomCount: Int, bathroomCount: Float, localizedCurrency: String, localizedNightlyPrice: Int) {
        self.city = city
        self.bedroomCount = bedroomCount
        self.bathroomCount = bathroomCount
        self.localizedCurrency = localizedCurrency
        self.localizedNightlyPrice = localizedNightlyPrice
    }
}

struct ListingContainer: Decodable {
    let search_results: [Listing]
}

extension Listing: Decodable {
    // Declaring our container keys
    enum Keys: String, CodingKey {
        case listing
        case pricingQuote = "pricing_quote"
    }
    
    enum ListingKeys: String, CodingKey {
        case bedrooms
        case bathrooms
        case city
    }
    
    enum PricingKeys: String, CodingKey {
        case localized_currency
        case localized_nightly_price
    }
    
    init(from decoder: Decoder) throws {
        // Define Keyed Container
        let container = try decoder.container(keyedBy: Keys.self)
        
        // Listing Container and attributes
        let listingContainer = try container.nestedContainer(keyedBy: ListingKeys.self, forKey: .listing)
        let bedrooms = try listingContainer.decodeIfPresent(Int.self, forKey: .bedrooms)
        let bathrooms = try listingContainer.decodeIfPresent(Float.self, forKey: .bathrooms)
        let city = try listingContainer.decodeIfPresent(String.self, forKey: .city)
        
        // Pricing Containter
        let pricingContainer = try container.nestedContainer(keyedBy: PricingKeys.self, forKey: .pricingQuote)
        let localizedurrency = try pricingContainer.decodeIfPresent(String.self, forKey: .localized_currency)
        let localizedNightlyPrice = try pricingContainer.decodeIfPresent(Int.self, forKey: .localized_nightly_price)
        print("City: \(city ?? "Danvilllle")")
        print("Bedrooms: \(bedrooms ?? 1000)")
        print("bathrooms: \(bathrooms ?? 10000)")
        print("localized currency: \(localizedurrency ?? "Mexico Dollars")")
        print("price: \(localizedNightlyPrice ?? 200000)")
        self.init(city: city!, bedroomCount: bedrooms!, bathroomCount: bathrooms!, localizedCurrency: localizedurrency!, localizedNightlyPrice: localizedNightlyPrice!)
    }
}


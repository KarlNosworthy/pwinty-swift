//
//  Catalogue.swift
//  Pwinty
//
//  Created by Karl Nosworthy on 10/03/2016.
//  Copyright © 2016 Karl Nosworthy. All rights reserved.
//

import Foundation
import Gloss



public struct Catalogue : Decodable {
    
    let countryCode:String?
    let country:String?
    let qualityLevel:QualityLevel?
    let items:[CatalogueItem]?
    let shippingRates:[ShippingRate]?

    
    public init?(json: JSON) {
        self.countryCode = "countryCode" <~~ json
        self.country = "country" <~~ json
        self.qualityLevel = "qualityLevel" <~~ json
        self.items = "items" <~~ json
        self.shippingRates = "shippingRates" <~~ json
    }
}

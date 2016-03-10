//
//  ShippingRate.swift
//  Pwinty
//
//  Created by Karl Nosworthy on 10/03/2016.
//  Copyright © 2016 Karl Nosworthy. All rights reserved.
//

import Foundation
import Gloss


struct ShippingRate : Decodable {
    
    let band:String?
    let description:String?
    // isTracked
    let priceGBP : Int?
    let priceUSD : Int?
    
    
    init?(json: JSON) {
        self.band = "band" <~~ json
        self.description = "description" <~~ json
//        self.isTracked = "isTracked" <~~ json
        self.priceGBP = "priceGBP" <~~ json
        self.priceUSD = "priceUSD" <~~ json
    }
}
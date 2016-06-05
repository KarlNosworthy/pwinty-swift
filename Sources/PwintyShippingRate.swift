//
//  PwintyShippingRate.swift
//  Pwinty
//
//  Created by Karl Nosworthy on 10/03/2016.
//  Copyright © 2016 Karl Nosworthy. All rights reserved.
//

import Foundation
import Gloss


public struct PwintyShippingRate : Decodable {
    
    public let band:String?
    public let description:String?
    public let isTracked:Bool?
    public let priceGBP : Int?
    public let priceUSD : Int?
    
    public init?(json: JSON) {
        self.band = "band" <~~ json
        self.description = "description" <~~ json
        self.isTracked = "isTracked" <~~ json
        self.priceGBP = "priceGBP" <~~ json
        self.priceUSD = "priceUSD" <~~ json
    }
}
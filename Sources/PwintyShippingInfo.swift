//
//  PwintyShippingInfo.swift
//  Pwinty
//
//  Created by Karl Nosworthy on 10/03/2016.
//  Copyright © 2016 Karl Nosworthy. All rights reserved.
//

import Foundation
import Gloss


struct PwintyShippingInfo : Decodable {
    
    let price:Int?
    let shipments:[PwintyShipment]?
    
    
    // MARK: Initialization
    
    init?(price:Int, shipments:[PwintyShipment]) {
        self.price = price;
        self.shipments = shipments;
    }
    
    init?(json:JSON) {
        self.price = "price" <~~ json
        self.shipments = "shipments" <~~ json
    }
}

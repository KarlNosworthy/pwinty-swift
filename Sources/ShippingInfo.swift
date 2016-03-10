//
//  ShippingInfo.swift
//  Pwinty
//
//  Created by Karl Nosworthy on 10/03/2016.
//  Copyright © 2016 Karl Nosworthy. All rights reserved.
//

import Foundation
import Gloss


struct ShippingInfo : Decodable {
    
    let price:Int?
    let shipments:[Shipment]?
    
    
    // MARK: Initialization
    
    init?(price:Int, shipments:[Shipment]) {
        self.price = price;
        self.shipments = shipments;
    }
    
    init?(json:JSON) {
        self.price = "price" <~~ json
        self.shipments = "shipments" <~~ json
    }
}

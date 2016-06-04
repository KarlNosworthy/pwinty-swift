//
//  PwintyShippingInfo.swift
//  Pwinty
//
//  Created by Karl Nosworthy on 10/03/2016.
//  Copyright © 2016 Karl Nosworthy. All rights reserved.
//

import Foundation
import Gloss


public struct PwintyShippingInfo : Decodable {
    
    public let price:Int?
    public let shipments:[PwintyShipment]?
    
    
    // MARK: Initialization
    
    public init?(price:Int, shipments:[PwintyShipment]) {
        self.price = price;
        self.shipments = shipments;
    }
    
    public init?(json:JSON) {
        self.price = "price" <~~ json
        self.shipments = "shipments" <~~ json
    }
}

//
//  PwintyShipment.swift
//  Pwinty
//
//  Created by Karl Nosworthy on 10/03/2016.
//  Copyright © 2016 Karl Nosworthy. All rights reserved.
//

import Foundation
import Gloss


struct PwintyShipment : Decodable {
    
    var shipmentId : String?
    var trackingNumber : String?
    var trackingUrl : String?
    var isTracked : Bool
    var earliestEstimatedArrivalDate : String?
    var latestEstimatedArrivalDate : String?
    var shippedOn : String?
    
    
    // MARK: Initialization
    
    init() {
        self.isTracked = false;
    }

    
    // MARK: - Deserialization
    
    init(json:JSON) {
        self.shipmentId = "shipmentId" <~~ json
        
        // the next property is boolean
        // can't currently decode - need custom decoder or extension or fix to Gloss?
        //self.isTracked = "isTracked" <~~ json
        self.isTracked = false
        
        self.trackingNumber = "trackingNumber" <~~ json
        self.trackingUrl = "trackingUrl" <~~ json
        self.earliestEstimatedArrivalDate = "earliestEstimatedArrivalDate" <~~ json
        self.latestEstimatedArrivalDate = "latestEstimatedArrivalDate" <~~ json
        self.shippedOn = "shippedOn" <~~ json
    }
}
//
//  Order.swift
//  Pwinty
//
//  Created by Karl Nosworthy on 10/03/2016.
//  Copyright © 2016 Karl Nosworthy. All rights reserved.
//

import Foundation
import Gloss



public struct Order : Decodable {
    
    var orderId: Int?
    var recipientName : String?
    var address1 : String?
    var address2 : String?
    var addressTownOrCity : String?
    var stateOrCounty : String?
    var postalOrZipCode : String?
    // country code
    // destination country code
    var price:Int?
    var status:OrderStatus?
    var useTrackedShipping : Bool
    var shippingInfo : ShippingInfo?
    // payment
    var paymentUrl : String?
    var qualityLevel : QualityLevel?
    var photos = [Photo]()
    var errorMessage : String?
    
    
    public init?(json: JSON) {
        self.orderId = "id" <~~ json
        self.recipientName = "recipientName" <~~ json
        self.address1 = "address1" <~~ json
        self.address2 = "address2" <~~ json
        self.addressTownOrCity = "addressTownOrCity" <~~ json
        self.stateOrCounty = "stateOrCounty" <~~ json
        self.postalOrZipCode = "postalOrZipCode" <~~ json
        // country code
        // destination country code
        self.price = "price" <~~ json
        self.status = "status" <~~ json
        self.shippingInfo = "shippingInfo" <~~ json
        // payment
        self.paymentUrl = "paymentUrl" <~~ json
        // quality level
        // photos
        //
        // temporarily hard-coded until bools from JSON is sorted
        self.useTrackedShipping = false;
    }
}

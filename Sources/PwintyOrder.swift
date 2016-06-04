//
//  PwintyOrder.swift
//  Pwinty
//
//  Created by Karl Nosworthy on 10/03/2016.
//  Copyright © 2016 Karl Nosworthy. All rights reserved.
//

import Foundation
import Gloss

public struct PwintyOrder : Decodable {
    
    public private(set) var orderId: Int?
    var recipientName : String?
    var address1 : String?
    var address2 : String?
    var addressTownOrCity : String?
    var stateOrCounty : String?
    var postalOrZipCode : String?
    var countryCode : String?
    var destinationCountryCode : String?
    var price:Int?
    var status:OrderStatus?
    var shippingInfo : PwintyShippingInfo?
    var payment:PaymentType?
    var paymentUrl : String?
    var qualityLevel : QualityLevel?
//    var photos = [Photo]()
    
    
    public init(countryCode:String, destinationCountryCode:String, qualityLevel:QualityLevel) {
        self.countryCode = countryCode
        self.destinationCountryCode = destinationCountryCode
        self.qualityLevel = qualityLevel
    }

    public init?(json: JSON) {
        self.orderId = "id" <~~ json
        self.recipientName = "recipientName" <~~ json
        self.address1 = "address1" <~~ json
        self.address2 = "address2" <~~ json
        self.addressTownOrCity = "addressTownOrCity" <~~ json
        self.stateOrCounty = "stateOrCounty" <~~ json
        self.postalOrZipCode = "postalOrZipCode" <~~ json
        self.countryCode = "countryCode" <~~ json
        self.destinationCountryCode = "destinationCountryCode" <~~ json
        self.price = "price" <~~ json
        self.status = "status" <~~ json
        self.shippingInfo = "shippingInfo" <~~ json
        self.payment = "payment" <~~ json
        self.paymentUrl = "paymentUrl" <~~ json
        self.qualityLevel = "qualityLevel" <~~ json
        
//        self.photos = ("photos" <~~ json)!
    }
}

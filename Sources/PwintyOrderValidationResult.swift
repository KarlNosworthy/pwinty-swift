//
//  PwintyOrderValidationResult.swift
//  Pwinty
//
//  Created by Karl Nosworthy on 12/03/2016.
//  Copyright © 2016 Karl Nosworthy. All rights reserved.
//

import Foundation
import Gloss

public struct PwintyOrderValidationResult : Decodable {
    
    let orderId:Int?
    let isValid:Bool?
    let photoErrors:[PwintyPhotoError]?
    let generalErrors:[String]?
    
    
    public init?(json:JSON) {
        self.orderId = "id" <~~ json
        // deal with booleans
        // self.isValid = "isValid" <~~ json
        self.isValid = false
        self.photoErrors = "photos" <~~ json
        self.generalErrors = "generalErrors" <~~ json
    }
}

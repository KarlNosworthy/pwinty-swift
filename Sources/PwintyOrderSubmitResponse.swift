//
//  OrderSubmitResponse.swift
//  Pwinty
//
//  Created by Karl Nosworthy on 14/03/2016.
//  Copyright © 2016 Karl Nosworthy. All rights reserved.
//

import Foundation
import Gloss

internal struct PwintyOrderSubmitResponse : Decodable {
    
    let errorMessage:String?
    
    init?(json: JSON) {
        self.errorMessage = "errorMessage" <~~ json
    }
}
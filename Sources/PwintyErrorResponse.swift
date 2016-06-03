//
//  PwintyErrorResponse.swift
//  Pwinty
//
//  Created by Karl Nosworthy on 03/06/2016.
//  Copyright © 2016 Karl Nosworthy. All rights reserved.
//

import Foundation
import Gloss

internal struct PwintyErrorResponse : Decodable {

    let errorMessage:String?

    init?(json: JSON) {
        errorMessage = "errorMessage" <~~ json
    }
    
    static func createError(json:JSON, httpStatusCode:Int) -> ErrorType {
        let errorMessage = PwintyErrorResponse(json: json)
        return NSError(domain: "Pwinty-Swift",
                       code: httpStatusCode,
                       userInfo: [NSLocalizedDescriptionKey : errorMessage!.errorMessage!])
    }
}

//
//  PhotoError.swift
//  Pwinty
//
//  Created by Karl Nosworthy on 12/03/2016.
//  Copyright © 2016 Karl Nosworthy. All rights reserved.
//

import Foundation
import Gloss


public struct PhotoError : Decodable {
    
    let photoId : Int?
    let errors : [String]?
    let warnings : [String]?
    
    
    public init?(json:JSON) {
        self.photoId = "id" <~~ json
        self.errors = "errors" <~~ json
        self.warnings = "warnings" <~~ json
    }
}

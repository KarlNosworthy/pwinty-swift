//
//  Photo.swift
//  Pwinty
//
//  Created by Karl Nosworthy on 10/03/2016.
//  Copyright © 2016 Karl Nosworthy. All rights reserved.
//

import Foundation
import Gloss

public struct Photo : Decodable {
    
    let photoId : Int?
    // type
    let url : String?
    // status
    let copies: Int?
    // sizing
    let price : Int?
    let priceToUser : Int?
    let md5Hash : String?
    let previewUrl : String?
    let thumbnailUrl : String?
    
    
    
    public init?(json: JSON) {
        photoId = "id" <~~ json
        url = "url" <~~ json
        copies = "copies" <~~ json
        price = "price" <~~ json
        priceToUser = "priceToUser" <~~ json
        md5Hash = "md5Hash" <~~ json
        previewUrl = "previewUrl" <~~ json
        thumbnailUrl = "thumbnailUrl" <~~ json
    }
    
}
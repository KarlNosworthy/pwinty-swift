//
//  CatalogueItem.swift
//  Pwinty
//
//  Created by Karl Nosworthy on 10/03/2016.
//  Copyright © 2016 Karl Nosworthy. All rights reserved.
//

import Foundation
import Gloss

struct CatalogueItem : Decodable {
    
    let name : String?
    let description : String?
    let imageHorizontalSize : Int?
    let imageVerticalSize : Int?
    let fullProductHorizontalSize : Int?
    let fullProductVerticalSize : Int?
    let sizeUnits : String?
    let priceGBP : Int?
    let priceUSD : Int?
    let recommendedHorizontalResolution : Int?
    let recommendedVerticalResolution : Int?

    
    
    init?(json: JSON) {
        self.name = "name" <~~ json
        self.description = "description" <~~ json
        self.imageHorizontalSize = "imageHorizontalSize" <~~ json
        self.imageVerticalSize = "imageVerticalSize" <~~ json
        self.fullProductHorizontalSize = "fullProductHorizontalSize" <~~ json
        self.fullProductVerticalSize = "fullProductVerticalSize" <~~ json
        self.sizeUnits = "sizeUnits" <~~ json
        self.priceGBP = "priceGBP" <~~ json
        self.priceUSD = "priceUSD" <~~ json
        self.recommendedHorizontalResolution = "recommendedHorizontalResolution" <~~ json
        self.recommendedVerticalResolution = "recommendedVerticalResolution" <~~ json
    }
}
//
//  PwintyPwintyCatalogueItem.swift
//  Pwinty
//
//  Created by Karl Nosworthy on 10/03/2016.
//  Copyright © 2016 Karl Nosworthy. All rights reserved.
//

import Foundation
import Gloss

public struct PwintyCatalogueItem : Decodable {
    
    public let name : String?
    public let description : String?
    public let imageHorizontalSize : Int?
    public let imageVerticalSize : Int?
    public let fullProductHorizontalSize : Int?
    public let fullProductVerticalSize : Int?
    public let sizeUnits : String?
    public let priceGBP : Int?
    public let priceUSD : Int?
    public let recommendedHorizontalResolution : Int?
    public let recommendedVerticalResolution : Int?

    
    
    public init?(json: JSON) {
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
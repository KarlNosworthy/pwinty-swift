//
//  PwintyPhoto.swift
//  Pwinty
//
//  Created by Karl Nosworthy on 10/03/2016.
//  Copyright © 2016 Karl Nosworthy. All rights reserved.
//

import Foundation
import Gloss

public struct PwintyPhoto : Decodable {
    
    public let photoId : Int?
    public let type : String?
    public let url : String?
    public let status : PwintyPhotoStatusType?
    public let copies: String?
    public let sizingType:PwintyPhotoSizingType?
    public let price : Int?
    public let priceToUser : Int?
    public let md5Hash : String?
    public let previewUrl : String?
    public let thumbnailUrl : String?
    public let attributes:[String:String]?
    
    public init?(json: JSON) {
        photoId = "id" <~~ json
        type = "type" <~~ json
        url = "url" <~~ json
        status = "status" <~~ json
        copies = "copies" <~~ json
        sizingType = "sizing" <~~ json
        price = "price" <~~ json
        priceToUser = "priceToUser" <~~ json
        md5Hash = "md5Hash" <~~ json
        previewUrl = "previewUrl" <~~ json
        thumbnailUrl = "thumbnailUrl" <~~ json
        attributes = "attributes" <~~ json
    }
}

public enum PwintyPhotoSizingType : String {
    case Crop = "Crop"
    case ShrinkToFit = "ShrinkToFit"
    case ShrinkToExactFit = "ShrinkToExactFit"
}

public enum PwintyPhotoStatusType : String {
    case AwaitingUrlOrData = "AwaitingUrlOrData"
    case NotYetDownloaded = "NotYetDownloaded"
    case Ok = "Ok"
    case FileNotFoundAtUrl = "FileNotFoundAtUrl"
    case Invalid = "Invalid"
}
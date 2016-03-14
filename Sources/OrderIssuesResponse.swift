//
//  Issues.swift
//  Pwinty
//
//  Created by Karl Nosworthy on 14/03/2016.
//  Copyright © 2016 Karl Nosworthy. All rights reserved.
//

import Foundation
import Gloss

internal struct OrderIssuesResponse : Decodable {
    
    let issues:[OrderIssue]?
    
    
    init?(json: JSON) {
        self.issues = "issues" <~~ json
    }
}

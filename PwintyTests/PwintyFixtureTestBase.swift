//
//  PwintyFixtureTestBase.swift
//  Pwinty
//
//  Created by Karl Nosworthy on 04/06/2016.
//  Copyright © 2016 Karl Nosworthy. All rights reserved.
//

import XCTest
import Mockingjay
import Pwinty

class PwintyFixtureTestBase: XCTestCase {
    
    
    func loadDataFromJSONFixture(resourceName:String, fixtureName:String) -> NSData? {
        let path = NSBundle(forClass: self.dynamicType).pathForResource(resourceName,
                                                                        ofType: "json",
                                                                        inDirectory: "fixtures/\(fixtureName)")
        return NSData(contentsOfFile: path!)
    }
    
    func matcher(request:NSURLRequest) -> Bool {
        return true  // Let's match this request
    }
}


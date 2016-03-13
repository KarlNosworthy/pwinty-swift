//
//  PwintyTests.swift
//  PwintyTests
//
//  Created by Karl Nosworthy on 10/03/2016.
//  Copyright © 2016 Karl Nosworthy. All rights reserved.
//

import XCTest
@testable import Pwinty


class PwintyTests: XCTestCase {
    
    let merchantId = "";
    let apiKey = "";
    
    
    var pwinty:Pwinty?
    
    
    override func setUp() {
        super.setUp()
        
        pwinty = Pwinty(merchantId:merchantId,
                                 apiKey:apiKey,
                           usingSandbox:true)
    }
    
    override func tearDown() {
        super.tearDown()
        pwinty = nil
    }

    
    func testGetCountries() {
        let readyExpectation = expectationWithDescription("ready")
        
        pwinty!.getCountries { (error, countries) -> Void in
            
            XCTAssertNil(error)
            XCTAssertNotNil(countries)
            XCTAssertEqual(243, countries!.count)
        
            readyExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(15) { error in
            XCTAssertNil(error, "Error")
        }
    }
    
    
    func testRequestGBProQualityCatalogue() {
        
        let readyExpectation = expectationWithDescription("ready")
        
        pwinty!.getCatalogue("GB", qualityLevel: QualityLevel.Pro, completionHandler: {
            (error, catalogue) -> Void in
            
            XCTAssertNotNil(catalogue)
            XCTAssertEqual(catalogue!.qualityLevel, QualityLevel.Pro)
            XCTAssertEqual(catalogue!.countryCode, "GB")
            
            readyExpectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(15) { error in
            XCTAssertNil(error, "Error")
        }
    }
    
    func testGetOrders() {
        
        let readyExpectation = expectationWithDescription("ready")
        
        pwinty?.getOrders({ (error, orders) -> Void in
            XCTAssertNil(error)
            XCTAssertNil(orders)
            
            readyExpectation.fulfill()
        })
    
        waitForExpectationsWithTimeout(15) { error in
            XCTAssertNil(error, "Error")
        }
    }
}
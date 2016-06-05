//
//  PwintyCatalogueTests.swift
//  Pwinty
//
//  Created by Karl Nosworthy on 05/06/2016.
//  Copyright © 2016 Karl Nosworthy. All rights reserved.
//

import XCTest
import Mockingjay
import Pwinty


class PwintyCatalogueTests: PwintyFixtureTestBase {
    
    func testSuccessfulCatalogueRequest() {
        let responseData = self.loadDataFromJSONFixture("catalogue_successful_response", fixtureName:"catalogue")
        
        XCTAssertNotNil(responseData)
        stub(matcher, builder: jsonData(responseData!))
        
        let readyExpectation = expectationWithDescription("ready")
        let pwinty = PwintyClient(merchantId: "", apiKey: "", usingSandbox: true)
        
        pwinty.getCatalogue("GB", qualityLevel: QualityLevel.Pro) { (error, catalogue) in
            
            XCTAssertNil(error)
            XCTAssertNotNil(catalogue)
            XCTAssertEqual(catalogue!.qualityLevel, QualityLevel.Pro)
            XCTAssertEqual(catalogue!.countryCode, "GB")
            
            
            
            
            
            //
            readyExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { error in
            XCTAssertNil(error, "Error")
        }
    }
    
    func testUnsuccessfulCatalogueRequest() {
        let responseData = self.loadDataFromJSONFixture("catalogue_unsuccessful_response_404", fixtureName:"catalogue")
        
        XCTAssertNotNil(responseData)
        stub(matcher, builder: jsonData(responseData!, status: 404))
        
        let readyExpectation = expectationWithDescription("ready")
        let pwinty = PwintyClient(merchantId: "", apiKey: "", usingSandbox: true)
        
        pwinty.getCatalogue("ZX", qualityLevel: QualityLevel.Pro) { (error, catalogue) in
            XCTAssertNil(catalogue)
            XCTAssertNotNil(error)
            XCTAssertEqual(404, error!._code)
            // assert message here as well
            
            readyExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { error in
            XCTAssertNil(error, "Error")
        }
    }
}

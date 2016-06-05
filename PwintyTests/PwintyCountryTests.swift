//
//  PwintyCountryTests.swift
//  Pwinty
//
//  Created by Karl Nosworthy on 05/06/2016.
//  Copyright © 2016 Karl Nosworthy. All rights reserved.
//

import XCTest
import Mockingjay
import Pwinty


class PwintyCountryTests: PwintyFixtureTestBase {
    
    func testSuccessfulListCountriesRequest() {
        let responseData = self.loadDataFromJSONFixture("country_list_successful_response", fixtureName:"country")
        
        XCTAssertNotNil(responseData)
        stub(matcher, builder: jsonData(responseData!))
        
        let readyExpectation = expectationWithDescription("ready")
        let pwinty = PwintyClient(merchantId: "", apiKey: "", usingSandbox: true)
        
        pwinty.getCountries { (error, countries) in
            
            XCTAssertNil(error)
            XCTAssertNotNil(countries)
            XCTAssertEqual(2, countries!.count)
            
            let uk = countries![0]
            XCTAssertEqual("GB", uk.countryCode)
            XCTAssertFalse(uk.hasProducts!)
            XCTAssertEqual("United Kingdom", uk.name)
            
            let us = countries![1]
            XCTAssertEqual("US", us.countryCode)
            XCTAssertTrue(us.hasProducts!)
            XCTAssertEqual("United States of America", us.name)
            
            readyExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { error in
            XCTAssertNil(error, "Error")
        }
    }
}

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
            XCTAssertEqual("United Kingdom", catalogue!.country)
            XCTAssertNotNil(catalogue!.items)
            XCTAssertEqual(1, catalogue!.items?.count)
            XCTAssertNotNil(catalogue!.shippingRates)
            XCTAssertEqual(1, catalogue!.shippingRates?.count)
            
            // catalogue item
            let catalogueItem = catalogue!.items![0]
            
            XCTAssertNotNil(catalogueItem)
            XCTAssertEqual("10x12", catalogueItem.name)
            XCTAssertEqual("10x12 Print", catalogueItem.description)
            XCTAssertEqual(10, catalogueItem.imageHorizontalSize)
            XCTAssertEqual(12, catalogueItem.imageVerticalSize)
            XCTAssertEqual(10, catalogueItem.fullProductHorizontalSize)
            XCTAssertEqual(12, catalogueItem.fullProductVerticalSize)
            XCTAssertEqual(150, catalogueItem.priceGBP)
            XCTAssertEqual(350, catalogueItem.priceUSD)
            XCTAssertEqual(1500, catalogueItem.recommendedHorizontalResolution)
            XCTAssertEqual(1800, catalogueItem.recommendedVerticalResolution)
            XCTAssertEqual("inches", catalogueItem.sizeUnits)

            // shipping rate
            let shippingRate = catalogue!.shippingRates![0]
            
            XCTAssertNotNil(shippingRate)
            XCTAssertEqual("Canvas", shippingRate.band!)
            XCTAssertEqual("Canvas tracked- UPS", shippingRate.description)
            XCTAssertTrue(shippingRate.isTracked!)
            XCTAssertEqual(700, shippingRate.priceGBP)
            XCTAssertEqual(1100, shippingRate.priceUSD)
            
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

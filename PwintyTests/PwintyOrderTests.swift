//
//  PwintyOrderTests.swift
//  Pwinty
//
//  Created by Karl Nosworthy on 04/06/2016.
//  Copyright © 2016 Karl Nosworthy. All rights reserved.
//

import XCTest
import Mockingjay
import Pwinty


class PwintyOrderTests: PwintyFixtureTestBase {

    func testSuccessfulOrderByIdRequest() {
        let responseData = self.loadDataFromJSONFixture("order_by_id_successful_response", fixtureName:"order")
        
        XCTAssertNotNil(responseData)
        stub(matcher, builder: jsonData(responseData!))
        
        let readyExpectation = expectationWithDescription("ready")
        let pwinty = PwintyClient(merchantId: "", apiKey: "", usingSandbox: true)
        
        pwinty.getOrder(1065) { (error, order) in
            XCTAssertNil(error)
            XCTAssertNotNil(order)
            XCTAssertEqual(1065, order!.orderId)
            XCTAssertEqual(1292, order!.price)
            
            // TODO: Assert other order values
            
            
            XCTAssertEqual(1, order!.photos!.count)
            
            let photo = order!.photos![0]
            XCTAssertNotNil(photo)
            XCTAssertEqual(3456, photo.photoId)
            XCTAssertEqual("4x6", photo.type!)
            XCTAssertTrue(PwintyPhotoStatusType.NotYetDownloaded.rawValue == photo.status!.rawValue)
            XCTAssertTrue(PwintyPhotoSizingType.Crop.rawValue == photo.sizingType!.rawValue)
            XCTAssertEqual(199, photo.price!)
            XCTAssertEqual(214, photo.priceToUser!)
            XCTAssertEqual("4", photo.copies!)
            XCTAssertEqual(1, photo.attributes!.count)
            XCTAssertNotNil(photo.attributes!["frame_colour"])
            XCTAssertEqual("silver", photo.attributes!["frame_colour"])
            
            readyExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { error in
            XCTAssertNil(error, "Error")
        }
    }
    
    
    func testUnsuccessfulOrderByIdRequest() {
        let responseData = self.loadDataFromJSONFixture("order_by_id_unsuccessful_response_404", fixtureName:"order")
        
        XCTAssertNotNil(responseData)
        stub(matcher, builder: jsonData(responseData!, status: 404))
        
        let readyExpectation = expectationWithDescription("ready")
        let pwinty = PwintyClient(merchantId: "", apiKey: "", usingSandbox: true)
        
        pwinty.getOrder(9023) { (error, order) in
            XCTAssertNil(order)
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

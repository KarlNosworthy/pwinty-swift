//
//  PwintyPhotoTests.swift
//  Pwinty
//
//  Created by Karl Nosworthy on 02/06/2016.
//  Copyright © 2016 Karl Nosworthy. All rights reserved.
//

import XCTest
import Mockingjay
import Pwinty

class PwintyPhotoTests: PwintyFixtureTestBase {
    
    func testSuccessfulPhotoByIdRequest() {
        let responseData = self.loadDataFromJSONFixture("photo_by_id_successful_response", fixtureName:"photo")
        
        XCTAssertNotNil(responseData)
        stub(matcher, builder: jsonData(responseData!))
        
        let readyExpectation = expectationWithDescription("ready")
        let pwinty = PwintyClient(merchantId: "", apiKey: "", usingSandbox: true)
            pwinty.getPhoto(1, photoId: 3456) { (error, photo) in
                
                XCTAssertNil(error)
                XCTAssertNotNil(photo)
                XCTAssertEqual(3456, photo!.photoId)
                XCTAssertEqual("4x6", photo!.type!)
                XCTAssertTrue(PwintyPhotoStatusType.NotYetDownloaded.rawValue == photo!.status!.rawValue)
                XCTAssertTrue(PwintyPhotoSizingType.Crop.rawValue == photo!.sizingType!.rawValue)
                XCTAssertEqual(199, photo!.price!)
                XCTAssertEqual(214, photo!.priceToUser!)
                XCTAssertEqual("4", photo!.copies!)
                XCTAssertEqual(1, photo!.attributes!.count)
                XCTAssertNotNil(photo!.attributes!["frame_colour"])
                XCTAssertEqual("silver", photo!.attributes!["frame_colour"])
                
                readyExpectation.fulfill()
            }
        
        waitForExpectationsWithTimeout(10) { error in
            XCTAssertNil(error, "Error")
        }
    }
    
    
    func testUnsuccessfulPhotoByIdRequest() {
        let responseData = self.loadDataFromJSONFixture("photo_by_id_unsuccessful_response_404", fixtureName:"photo")
        
        XCTAssertNotNil(responseData)
        stub(matcher, builder: jsonData(responseData!, status: 404))
        
        let readyExpectation = expectationWithDescription("ready")
        let pwinty = PwintyClient(merchantId: "", apiKey: "", usingSandbox: true)
        pwinty.getPhoto(1, photoId: 0910) { (error, photo) in
            
            XCTAssertNil(photo)
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

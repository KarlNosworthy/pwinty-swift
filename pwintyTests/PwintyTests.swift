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
    
    var merchantId:String?
    var apiKey:String?
    
    var pwinty:Pwinty?
    
    
    override func setUp() {
        super.setUp()
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let filename = bundle.pathForResource("pwinty_settings", ofType: "plist", inDirectory: "config")
        
        let settings = NSDictionary(contentsOfFile: filename!)
        
        merchantId = settings!["PWMerchantIdentifier"] as? String
        apiKey = settings!["PWAPIKey"] as? String
        
        pwinty = Pwinty(merchantId:merchantId!,
                                 apiKey:apiKey!,
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
    
/*
    func testGetOrders() {
        
        let readyExpectation = expectationWithDescription("ready")
        
        pwinty?.getOrders({ (error, orders) -> Void in
            XCTAssertNil(error)
            XCTAssertNotNil(orders)
            
            readyExpectation.fulfill()
        })
    
        waitForExpectationsWithTimeout(15) { error in
            XCTAssertNil(error, "Error")
        }
    }
    
    func testCreateOrder() {
        
        let readyExpectation = expectationWithDescription("ready")
        
        pwinty?.createOrder("Bob Tester", countryCode: "GB", destinationCountryCode: "GB",
                                          paymentType: PaymentType.InvoiceMe,
                                         qualityLevel: QualityLevel.Standard,
                                    completionHandler: { (error, order) -> Void in
                                        
            XCTAssertNil(error)
            XCTAssertNotNil(order)
                                        
            readyExpectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(15) { error in
            XCTAssertNil(error, "Error")
        }
    }
*/
    
    func testOrderIssueProcess() {
        
        let readyExpectation = expectationWithDescription("ready")
        
        pwinty?.getOrders({ (error, orders) -> Void in
            
            XCTAssertNil(error)
            XCTAssertNotNil(orders)
            XCTAssertEqual(2, orders?.count)
            
            let order = orders![0]
            
            self.pwinty?.getOrderIssues(order.orderId!, completionHandler: { (error, issues) -> Void in
                
                XCTAssertNil(error)
                XCTAssertNotNil(issues)
                XCTAssertEqual(1, issues!.count)
                
                let orderIssue = issues![0]
                
                self.pwinty?.cancelOrderIssue(orderIssue.orderId!, issueId: orderIssue.issueId!, comment: "Actually, I like the frame so I'm cancelling this issue.", completionHandler: { (error, updatedOrderIssue) -> Void in
                    
                    XCTAssertNil(error)
                    XCTAssertNotNil(updatedOrderIssue)
                    XCTAssertEqual("Cancelled", updatedOrderIssue?.issueState)
                    
                    readyExpectation.fulfill()
                })
            })
        })
        
        waitForExpectationsWithTimeout(60) { error in
            XCTAssertNil(error, "Error")
        }
    }
    
    
    func testCreatingAndSubmittingAnOrder() {
        
        let readyExpectation = expectationWithDescription("ready")
        
        pwinty?.getOrders({ (error, orders) -> Void in
            
            XCTAssertNil(error)
            XCTAssertNotNil(orders)
            XCTAssertEqual(2, orders?.count)
            
            let order = orders![1]
            
            self.pwinty?.submitOrder(order.orderId!, completionHandler: { (error) -> Void in
                XCTAssertNil(error)
                
                readyExpectation.fulfill()
            })
        })

        waitForExpectationsWithTimeout(15) { error in
            XCTAssertNil(error, "Error")
        }
    }
}
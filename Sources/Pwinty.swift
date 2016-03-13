//
//  Pwinty.swift
//  Pwinty
//
//  Created by Karl Nosworthy on 10/03/2016.
//  Copyright © 2016 Karl Nosworthy. All rights reserved.
//

import Foundation
import Alamofire
import Gloss


public class Pwinty {
    
    let usingSandbox : Bool?
    let merchantId : String?
    let apiKey: String?

    
    init(merchantId:String, apiKey:String, usingSandbox:Bool) {
        self.merchantId = merchantId;
        self.apiKey = apiKey;
        self.usingSandbox = usingSandbox;
    }
    
    func isUsingSandbox() -> Bool {
        return self.usingSandbox!
    }
    
    //
    // Countries
    //
    public func getCountries(completionHandler:(error:NSError?, countries:[Country]?) -> Void) {
        
        let countriesRequestUrl = String(format: "%@/Country", getApiRequestUrl())
        
        Alamofire.request(.GET, countriesRequestUrl, encoding: .JSON, headers: getApiRequestHeaders()).responseJSON {(response) in
            
            do {
                if (response.result.error != nil) {
                    completionHandler(error:response.result.error, countries:nil)
                } else {
                    let deserialisedJSON = try  NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions())
                    let countries = [Country].fromJSONArray(deserialisedJSON as! [JSON])
                    
                    completionHandler(error:response.result.error, countries: countries);
                }
            } catch let error as NSError {
                completionHandler(error:error, countries: nil);
            }
        }
    }
    
    //
    // Catalogue
    //
    
    public func getCatalogue(countryCode:String, qualityLevel:QualityLevel, completionHandler:(error:NSError?, catalogue:Catalogue?) -> Void) {
        
        let catalogueRequestUrl = String(format: "%@/Catalogue/%@/%@", getApiRequestUrl(),"GB", qualityLevel.rawValue)
        
        Alamofire.request(.GET, catalogueRequestUrl, encoding: .JSON, headers: getApiRequestHeaders()).responseJSON {(JSON) in
            
            do {
                let deserialisedJSON = try  NSJSONSerialization.JSONObjectWithData(JSON.data!, options: NSJSONReadingOptions()) as? [String: AnyObject]
                
                let catalogue = Catalogue(json: deserialisedJSON!)
                
                completionHandler(error:JSON.result.error, catalogue:catalogue)
            } catch let error as NSError {
                completionHandler(error:error, catalogue: nil)
            }
        }
    }
    
    //
    // Orders
    //
    
    public func getOrders(completionHandler:(error:NSError?, orders:[Order]?) -> Void) {
        
        let ordersRequestUrl = String(format: "%@/Orders", getApiRequestUrl())
        
        Alamofire.request(.GET, ordersRequestUrl, encoding: .JSON, headers: getApiRequestHeaders()).responseJSON {(response) in
            
            do {
                if (response.result.error != nil) {
                    completionHandler(error:response.result.error, orders:nil)
                } else {
                    if (response.response?.statusCode == 200) {
                        let deserialisedJSON = try  NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions())
                        let orders = [Order].fromJSONArray(deserialisedJSON as! [JSON])
                        
                        completionHandler(error:response.result.error, orders:orders);
                    } else {
                        completionHandler(error:response.result.error, orders:nil);
                    }
                }
            } catch let error as NSError {
                completionHandler(error:error, orders: nil);
            }
        }
    }

    
    public func getOrder(orderId:Int, completionHandler:(error:NSError?, order:Order?) -> Void) {
        
        let orderByIdRequestUrl = String(format: "%@/Orders/%ld", getApiRequestUrl(), orderId)
        
        Alamofire.request(.GET, orderByIdRequestUrl, encoding: .JSON, headers: getApiRequestHeaders()).responseJSON {(JSON) in
            
            do {
                let deserialisedJSON = try  NSJSONSerialization.JSONObjectWithData(JSON.data!, options: NSJSONReadingOptions()) as? [String: AnyObject]
                
                let order = Order(json: deserialisedJSON!)
                
                completionHandler(error:JSON.result.error, order:order)
            } catch let error as NSError {
                completionHandler(error:error, order: nil)
            }
        }
    }
    
    
    public func validateOrder(orderId:Int, completionHandler:(error:NSError?, validationResult:OrderValidationResult?) -> Void) {
        
        let validateOrderRequestUrl = String(format: "%@/Orders/%ld/SubmissionStatus", getApiRequestUrl(), orderId)
        
        Alamofire.request(.GET, validateOrderRequestUrl, encoding: .JSON, headers: getApiRequestHeaders()).responseJSON {(JSON) in
            
            do {
                let deserialisedJSON = try  NSJSONSerialization.JSONObjectWithData(JSON.data!, options: NSJSONReadingOptions()) as? [String: AnyObject]
                
                let validationResult = OrderValidationResult(json:deserialisedJSON!)
                
                completionHandler(error:JSON.result.error, validationResult:validationResult)
            } catch let error as NSError {
                completionHandler(error:error, validationResult: nil)
            }
        }
    }
    
    
    public func updateOrder(orderId:Int, recipientName:String = "", address1:String = "", address2:String = "",
        addressTownOrCity:String = "", stateOrCounty:String = "", postalOrZipCode:String = "", completionHandler:(error:NSError?, order:Order?) -> Void) {
            
        var parameters = [String:AnyObject]()
            
        if (!recipientName.isEmpty) {
            parameters["recipientName"] = recipientName
        }
        
        if (!address1.isEmpty) {
            parameters["address1"] = address1
        }
            
        if (!address2.isEmpty) {
            parameters["address2"] = address2
        }
            
        if (!addressTownOrCity.isEmpty) {
            parameters["addressTownOrCity"] = addressTownOrCity
        }
            
        if (!stateOrCounty.isEmpty) {
            parameters["stateOrCounty"] = stateOrCounty
        }
        
        if (!postalOrZipCode.isEmpty) {
            parameters["postalOrZipCode"] = postalOrZipCode
        }
            
        let updateOrderRequestUrl = String(format: "%@/Orders/%ld", getApiRequestUrl(), orderId)
            
        Alamofire.request(.PUT, updateOrderRequestUrl, parameters: parameters, encoding: .JSON, headers: getApiRequestHeaders()).responseJSON {(JSON) in
            do {
                let deserialisedJSON = try  NSJSONSerialization.JSONObjectWithData(JSON.data!, options: NSJSONReadingOptions()) as? [String: AnyObject]
                
                let order = Order(json: deserialisedJSON!)
                
                completionHandler(error: nil, order: order)
                
            } catch let error as NSError {
                completionHandler(error:error, order: nil)
            }
        }
    }
    
    
    

/*
    Order createOrder(Order newOrder, boolean useTrackedShipping) {
    Form form = createOrderForm(newOrder, useTrackedShipping);
    ClientResponse response = webResource.path("Orders")
    .type(MediaType.APPLICATION_FORM_URLENCODED_TYPE)
    .accept(MediaType.APPLICATION_JSON_TYPE)
    .header("X-Pwinty-MerchantId", merchantId)
    .header("X-Pwinty-REST-API-Key", apiKey)
    .post(ClientResponse.class, form);
    
    Order createdOrder = createReponse(response, Order.class);
    createdOrder.setPwinty(this);
    
    for (Photo photo : newOrder.getPhotos()) {
    createdOrder.addPhoto(photo.getUrl(), photo.getType(),
    photo.getCopies(), photo.getSizing());
    }
    return createdOrder;
    }*/
    
    
    public func createOrder(orderDetails:Order, useTrackedShipping:Bool) -> Order {
        
        // create order parameters (form)
        // post order to service endpoint
        // process response
        // move photos over to response order
        // return response order

        let order = Order(json: ["":""])
            
        
        return order!
    }
    
    // public func submitOrder ... either with order object or with by id
    
    //
    // Order Issues
    //
    
    public func createOrderIssue(orderId:Int, issueType:IssueType, issueDetail:String, requiredAction:IssueActionType, actionDetail:String = "", affectedImages:[Int] = [], completionHandler:(error:ErrorType?, orderIssue:OrderIssue?) -> Void) {
        
        let createOrderIssueRequestUrl = String(format: "%@/Orders/%@/Issues", getApiRequestUrl(), orderId)
        
        var parameters = [String:AnyObject]()
            parameters["orderId"] = orderId
            parameters["issue"] = issueType.rawValue
            parameters["action"] = requiredAction.rawValue
        
        if (!issueDetail.isEmpty) {
            parameters["issueDetail"] = issueDetail
        }
        
        if (!actionDetail.isEmpty) {
            parameters["actionDetail"] = actionDetail
        }
        
        if (affectedImages.count > 0) { // include the image id's
            parameters["affectedImages"] = affectedImages
        }
        
        Alamofire.request(.POST, createOrderIssueRequestUrl, parameters:parameters, encoding: .JSON, headers: getApiRequestHeaders()).responseJSON {(response) in
            
            do {
                if (response.result.error != nil) {
                    completionHandler(error:response.result.error, orderIssue:nil)
                } else {
                    if (response.response?.statusCode == 200) {
                        
                        let deserialisedJSON = try  NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions()) as? [String: AnyObject]
                        
                        let orderIssue = OrderIssue(json:deserialisedJSON!)
                        
                        completionHandler(error:response.result.error, orderIssue:orderIssue)
                    } else {
                        completionHandler(error:response.result.error, orderIssue:nil)
                    }
                }
            } catch {
                completionHandler(error:error, orderIssue:nil)
            }
        }
    }
    
    
    public func getOrderIssues(orderId:Int, completionHandler:(error:ErrorType?, issues:[OrderIssue]?) -> Void) {
        
        let orderIssuesRequestUrl = String(format: "%@/Orders/%@/Issues", getApiRequestUrl(), orderId)
        
        Alamofire.request(.GET, orderIssuesRequestUrl, encoding: .JSON, headers: getApiRequestHeaders()).responseJSON {(response) in
            
            do {
                if (response.result.error != nil) {
                    completionHandler(error:response.result.error, issues:nil)
                } else {
                    if (response.response?.statusCode == 200) {
                        let deserialisedJSON = try  NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions())
                        let issues = [OrderIssue].fromJSONArray(deserialisedJSON as! [JSON])
                        
                        completionHandler(error:response.result.error, issues:issues);
                    } else {
                        completionHandler(error:response.result.error, issues:nil);
                    }
                }
            } catch {
                completionHandler(error:error, issues:nil);
            }
        }
    }
    
    public func getOrderIssue(orderId:Int, issueId:Int, completionHandler:(error:NSError?, orderIssue:OrderIssue?) -> Void) {
        
        let orderIssueRequestUrl = String(format: "%@/Orders/%@/Issues/%@", getApiRequestUrl(), orderId, issueId)
        
        Alamofire.request(.GET, orderIssueRequestUrl, encoding: .JSON, headers: getApiRequestHeaders()).responseJSON {(JSON) in
            
            do {
                let deserialisedJSON = try  NSJSONSerialization.JSONObjectWithData(JSON.data!, options: NSJSONReadingOptions()) as? [String: AnyObject]
                
                let orderIssue = OrderIssue(json: deserialisedJSON!)
                
                completionHandler(error:JSON.result.error, orderIssue:orderIssue)
            } catch let error as NSError {
                completionHandler(error:error, orderIssue: nil)
            }
        }
    }
    
    
    public func commentOnOrderIssue(orderId:Int, issueId:Int, comment:String, completionHandler:(error:NSError?, updatedOrderIssue:OrderIssue?) -> Void) {
        
        let orderIssueCommentUrl = String(format: "%@/Orders/%@/Issues/%@", getApiRequestUrl(), orderId, issueId)
        
        let parameters = ["comment" : comment]
        
        Alamofire.request(.PUT, orderIssueCommentUrl, parameters:parameters, encoding: .JSON, headers: getApiRequestHeaders()).responseJSON {(JSON) in
            
            do {
                let deserialisedJSON = try  NSJSONSerialization.JSONObjectWithData(JSON.data!, options: NSJSONReadingOptions()) as? [String: AnyObject]
                
                let orderIssue = OrderIssue(json: deserialisedJSON!)
                
                completionHandler(error:JSON.result.error, updatedOrderIssue:orderIssue)
            } catch let error as NSError {
                completionHandler(error:error, updatedOrderIssue: nil)
            }
        }
    }
    
    
    public func cancelOrderIssue(orderId:Int, issueId:Int, comment:String = "", completionHandler:(error:NSError?, updatedOrderIssue:OrderIssue?) -> Void) {
        
        let orderIssueCancelUrl = String(format: "%@/Orders/%@/Issues/%@", getApiRequestUrl(), orderId, issueId)

        var parameters = [String:AnyObject]()
            parameters[""] = "Cancelled"
        
        if (!comment.isEmpty) {
            parameters["comment"] = comment
        }
        
        Alamofire.request(.PUT, orderIssueCancelUrl, parameters:parameters, encoding: .JSON, headers: getApiRequestHeaders()).responseJSON {(JSON) in
            
            do {
                let deserialisedJSON = try  NSJSONSerialization.JSONObjectWithData(JSON.data!, options: NSJSONReadingOptions()) as? [String: AnyObject]
                
                let orderIssue = OrderIssue(json: deserialisedJSON!)
                
                completionHandler(error:JSON.result.error, updatedOrderIssue:orderIssue)
            } catch let error as NSError {
                completionHandler(error:error, updatedOrderIssue: nil)
            }
        }
    }
    
    
    private func getApiRequestUrl() -> String {
        if (isUsingSandbox()) {
            return "https://sandbox.pwinty.com/v2.2"
        } else {
            return "https://api.pwinty.com/v2.2"
        }
    }
    
    private func getApiRequestHeaders() -> [String:String] {
        return [ "Content-Type": "application/json",
                 "X-Pwinty-MerchantId" : self.merchantId!,
                 "X-Pwinty-REST-API-Key" : self.apiKey! ]
    }
}

public enum PaymentType : String {
    case InvoiceMe = "InvoiceMe"
    case InvoiceRecipient = "InvoiceRecipient"
}

public enum QualityLevel : String {
    case Pro = "Pro"
    case Standard = "Standard"
}

public enum OrderStatus : String {
    case NotYetSubmitted = "NotYetSubmitted"
    case Submitted = "Submitted"
    case AwaitingPayment = "AwaitingPayment"
    case Complete = "Complete"
    case Cancelled = "Cancelled"
}

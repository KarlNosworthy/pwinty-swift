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
                    let deserialisedJSON = try  NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions())
                    let orders = [Order].fromJSONArray(deserialisedJSON as! [JSON])
                    
                    completionHandler(error:response.result.error, orders:orders);
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

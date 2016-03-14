# pwinty-swift
A swift client library for communicating with the Pwinty API http://www.pwinty.com/api.html

#### Cocoapods
#### Swift Package Manager
#### Carthage

## Getting Started
```swift
  import Pwinty
```  

### Initialising
```swift
  let pwinty = Pwinty(merchantId:"<your id here>", apiKey:"<your key here>", usingSandbox:false)
```

### Creating an Order
```swift
  pwinty.createOrder(recipientName:"Joe Test", 
                       countryCode:"GB", 
                       paymentType:PaymentType.InvoiceRecipient, 
                      qualityLevel:QualityLevel.Pro, 
                 completionHandler:{ (error, order) -> Void in
                                     // you'll have your persisted order or an error instance here  
                                   })
```

### Adding a Photo to an Order

### Deleting a Photo

### Submitting an Order

### Raising an Issue

If you have a problem with a particular order, you can raise an issue.
```swift
  pwinty.createOrderIssue(order.orderId, 
                               issueType:IssueType.IncorrectOrientation, 
                             issueDetail:"Photos are the wrong orientation", 
                          requiredAction:IssueActionType.Reprint, 
                       completionHandler:{ (error, orderIssue) -> Void in
                                           // you'll have your persisted order issue or an error here  
                                         })
```
### Commenting on an Issue
### Cancelling an Issue

## Testing
You want to run the tests....GREAT! So, you'll need a few things. 

Firstly, you'll need a __Merchant ID__ and __Api Key__ to access Pwinty.

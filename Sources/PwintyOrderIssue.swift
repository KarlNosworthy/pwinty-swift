//
//  PwintyOrderIssue.swift
//  Pwinty
//
//  Created by Karl Nosworthy on 13/03/2016.
//  Copyright © 2016 Karl Nosworthy. All rights reserved.
//

import Foundation
import Gloss


public struct PwintyOrderIssue : Decodable {

    let issueId : Int?
    let orderId : Int?
    let issueType : IssueType?
    let action : IssueActionType?
    let actionDetail : String?
    let affectedImages:[String]?
    let issueState : String?
    let commentary : String?
    
    
    public init?(json:JSON) {
        self.issueId = "id" <~~ json
        self.orderId = "orderId" <~~ json
        self.issueType = "issue" <~~ json
        self.action = "action" <~~ json
        self.actionDetail = "actionDetail" <~~ json
        self.affectedImages = "affectedImages" <~~ json
        self.issueState = "issueState" <~~ json
        self.commentary = "commentary" <~~ json
    }
}

public enum IssueActionType : String {
    case Refund = "Refund"
    case Reprint = "Reprint"
    case NoAction = "NoAction"
    case Other = "Other"
}

public enum IssueType : String {
    case DamagedOrder = "DamagedOrder"
    case WrongFrameColour = "WrongFrameColour"
    case IncompleteOrder = "IncompleteOrder"
    case LostInPost = "LostInPost"
    case IncorrectOrientation = "IncorrectOrientation"
    case IncorrectPrints = "IncorrectPrints"
    case PrintDefects = "PrintDefects"
    case SlowArrival = "SlowArrival"
    case SlowDispatch = "SlowDispatch"
    case SubmissionErrors = "SubmissionErrors"
    case WrongAddress = "WrongAddress"
    case Unspecified = "Unspecified"
}

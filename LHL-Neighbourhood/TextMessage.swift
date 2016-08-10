//
//  TextMessage.swift
//  LHL-Neighbourhood
//
//  Created by Asuka Nakagawa on 2016-08-09.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import UIKit
import Parse

class TextMessage: PFObject, PFSubclassing {
    
    // Custom properties
    @NSManaged var text: String
    @NSManaged var senderID: String
    @NSManaged var attachment: PFFile?
    
    
    convenience init(text:String, senderID:String, attachment:PFFile) {
        self.init()
        self.text = text
        self.senderID = senderID
        self.attachment = attachment
    }
    
    static func parseClassName() -> String {
        return "Textmessage"
    }

    //    override class func initialize() {
    //        struct Static {
    //            static var onceToken : dispatch_once_t = 0
    //        }
    //
    //        // once
    //        dispatch_once(&Static.onceToken) {
    //            self.registerSubclass()
    //        }
    //    }
}

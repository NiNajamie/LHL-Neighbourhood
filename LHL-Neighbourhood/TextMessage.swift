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
    @NSManaged var senderID: User
    @NSManaged var attachment: PFFile?
    
    @NSManaged var senderStr: String

    static func parseClassName() -> String {
        return "TextMessage"
    }
    
    convenience init(text:String, senderID: User, attachment:PFFile, senderStr: String) {
        self.init()
        self.text = text
        self.senderID = senderID
        self.attachment = attachment
        self.senderStr = senderStr
    }
}

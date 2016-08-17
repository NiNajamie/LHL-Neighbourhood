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
    @NSManaged var sender: User
//    @NSManaged var receiver: User
    @NSManaged var conversation: Conversation
    
//    @NSManaged var attachment: PFFile?
    

    static func parseClassName() -> String {
        return "TextMessage"
    }
    
    convenience init?(text:String, sender: User?, conversation: Conversation) {
        self.init()
        
        guard let sender = sender else { return nil }
        
        self.text = text
        self.sender = sender
//        self.attachment = attachment
//        self.receiver = receiver
        self.conversation = conversation
        
        
    }
}

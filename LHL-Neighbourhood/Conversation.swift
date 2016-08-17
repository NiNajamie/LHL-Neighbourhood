//
//  Conversation.swift
//  LHL-Neighbourhood
//
//  Created by Asuka Nakagawa on 2016-08-15.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import UIKit
import Parse


class Conversation: PFObject, PFSubclassing {

    @NSManaged var owner: User
    @NSManaged var notOwner: User
    @NSManaged var tool: Tool
//    @NSManaged var messageArray: [TextMessage]
    
    static func parseClassName() -> String {
        return "Conversation"
    }
    
    convenience init(owner: User, notOwner: User, tool: Tool) {
        self.init()
        self.owner = owner
        self.notOwner = notOwner
        self.tool = tool
//        self.messageArray = messageArray
    }
}

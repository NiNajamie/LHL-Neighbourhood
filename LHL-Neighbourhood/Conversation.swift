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

    @NSManaged var poster: PFUser
    @NSManaged var applicant: PFUser
    @NSManaged var tool: Tool
    @NSManaged var messageArray: NSMutableArray
    
    static func parseClassName() -> String {
        return "Conversation"
    }
    
    convenience init(poster: PFUser, applicant: PFUser, tool: Tool, messageArray: NSMutableArray) {
        self.init()
        self.poster = poster
        self.applicant = applicant
        self.tool = tool
        self.messageArray = messageArray
    }
}

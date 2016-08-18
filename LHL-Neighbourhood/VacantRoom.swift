//
//  VacantRoom.swift
//  LHL-Neighbourhood
//
//  Created by reena on 13/08/16.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import UIKit
import Parse

class VacantRoom: PFObject, PFSubclassing {
    // Custom properties
    @NSManaged var room: String
    @NSManaged var roomInfo: String
   
    convenience init(room:String, description:String) {
        self.init()
        self.room = room
        self.roomInfo = description
    }
    
    static func parseClassName() -> String {
        return "VacantRoom"
    }
    
    
    
    
    
}


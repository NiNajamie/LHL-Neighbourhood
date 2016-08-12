//
//  ManagerPost.swift
//  LHL-Neighbourhood
//
//  Created by reena on 11/08/16.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import UIKit
import Parse

class ManagerPost: PFObject, PFSubclassing {
    // Custom properties
    @NSManaged var title: String
    @NSManaged var postDescription: String
    @NSManaged var eventDate: NSDate
    @NSManaged var managerName: String
    
    convenience init(title:String, description:String, eventDate:NSDate, managerName:String) {
        self.init()
        self.title = title
        self.postDescription = description
        self.eventDate = eventDate
        self.managerName = managerName
    }
    
    static func parseClassName() -> String {
        return "ManagerPost"
    }

    
    

    
}

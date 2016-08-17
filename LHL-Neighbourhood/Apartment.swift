//
//  Apartment.swift
//  LHL-Neighbourhood
//
//  Created by reena on 15/08/16.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import UIKit
import Parse

class Apartment: PFObject, PFSubclassing {
    // Custom properties
    @NSManaged var name: String
    @NSManaged var user: User
   
    //@NSManaged var managerName: String
    
    convenience init(name:String, user:User) {
        self.init()
        self.name = name
        self.user = user
//        self.managerName = managerName
    }
    
    static func parseClassName() -> String {
        return "Apartment"
    }
    
    
    
    
    
}



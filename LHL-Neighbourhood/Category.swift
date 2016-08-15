//
//  Category.swift
//  LHL-Neighbourhood
//
//  Created by Asuka Nakagawa on 2016-08-14.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import UIKit
import Parse

class Category: PFObject, PFSubclassing {
    
    @NSManaged var displayName: String
    @NSManaged var key: String
    
    static func parseClassName() -> String {
        return "Category"
    }
    
    convenience init(displayName: String, key: String) {
        self.init()
        self.displayName = displayName
        self.key = key
    }
}

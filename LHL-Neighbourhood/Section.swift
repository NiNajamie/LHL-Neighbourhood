//
//  Section.swift
//  LHL-Neighbourhood
//
//  Created by Asuka Nakagawa on 2016-08-09.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import Foundation
import Parse

class Section: PFObject, PFSubclassing {
    
    @NSManaged var displayName: String
    @NSManaged var key: String
    
    static func parseClassName() -> String {
        return "Section"
    }
    
    convenience init(displayName: String, key: String) {
        self.init()
        self.displayName = displayName
        self.key = key
    }
}

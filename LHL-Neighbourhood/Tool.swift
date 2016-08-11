//
//  Tool.swift
//  LHL-Neighbourhood
//
//  Created by Asuka Nakagawa on 2016-08-11.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import UIKit
import Parse

struct Tool {
    var name: String
    var photo: PFFile
    var postedBy: PFUser
    var category: String
    var sectionStr: String
    var availability: String
    var price: String
    
    
    static func parseClassName() -> String {
        return "Tool"
    }
}

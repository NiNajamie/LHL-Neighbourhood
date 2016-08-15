//
//  Tool.swift
//  LHL-Neighbourhood
//
//  Created by Asuka Nakagawa on 2016-08-11.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import UIKit
import Parse

class Tool: PFObject, PFSubclassing {
    
    
    @NSManaged var name: String
    @NSManaged var photo: PFFile
    @NSManaged var postedBy: PFUser
    @NSManaged var category: Category
    @NSManaged var section: Section
    @NSManaged var availability: String
    @NSManaged var price: String
    
    static func parseClassName() -> String {
        return "Tool"
    }
    
    
    convenience init(name: String, photo: PFFile, category: Category, section: Section, availability: String, price: String, postedBy: PFUser) {
        
        self.init()
        self.name = name
        self.photo = photo
        self.category = category
        self.section = section
        self.availability = availability
        self.price = price
        self.postedBy = postedBy
    }
    
    
}

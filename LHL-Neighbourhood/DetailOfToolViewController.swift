//
//  DetailOfToolViewController.swift
//  LHL-Neighbourhood
//
//  Created by Asuka Nakagawa on 2016-08-09.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import UIKit

class DetailOfToolViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var secLabel: UILabel!
    
    // I have responsibility for there is a tool Object, force it
    var tool: Tool!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = tool.name
//        categoryLabel.text = tool.category.displayName
//        secLabel.text = tool.section.displayName

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//
//  DetailOfToolViewController.swift
//  LHL-Neighbourhood
//
//  Created by Asuka Nakagawa on 2016-08-09.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import UIKit
import Parse

class DetailOfToolViewController: UIViewController {

    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var secLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var availabilityLabel: UILabel!
    
    
    // I have responsibility for there is a tool Object, force it
    var tool: Tool!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let imagePFFile = tool.photo as? PFFile {
            imagePFFile.getDataInBackgroundWithBlock({
                (imageData, error) -> Void in
                if (error == nil) {
                    let image = UIImage(data: imageData!)
                    self.photoImageView.image = image
                }
            })
        }
        
        nameLabel.text = tool.name
        categoryLabel.text = tool.category.displayName
        secLabel.text = tool.section.displayName
        priceLabel.text = tool.price
        availabilityLabel.text = tool.availability
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

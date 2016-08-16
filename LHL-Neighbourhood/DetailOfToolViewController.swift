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
    
    @IBOutlet weak var postedByLabel: UILabel!
    

    var tool: Tool!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        if let imagePFFile = tool.photo {
            imagePFFile.getDataInBackgroundWithBlock({
                (imageData, error) -> Void in
                if let imageData = imageData {
                    self.photoImageView.image = UIImage(data: imageData)
                } else {
                    print("error \(error)")
                }
            })
        }
        
        if let user = tool.postedBy as? User {
            
            postedByLabel.text?.appendContentsOf(user.username!)
            nameLabel.text = tool.name
            categoryLabel.text = tool.category.displayName
            secLabel.text = tool.section.displayName
            priceLabel.text = tool.price
            availabilityLabel.text = tool.availability
        }
    }

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if let chatvc = segue.destinationViewController as? ChatViewController {
            chatvc.tool = tool
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

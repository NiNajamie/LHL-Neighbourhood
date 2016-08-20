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

        /*
         
         PFFile *file = tool.photo;
         
        if (file) {
         
         [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
            if (data) {
                UIImage *image = [[UIImage alloc] initWithData:data];
                self.photoImageview.image = image;
            }
         
         
         }];
         
        }
        
        */
        
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
        
        if let user = tool.postedBy as? User { // CR: just change the class of postedBy?
            
            postedByLabel.text?.appendContentsOf(user.username!) // CR: unwrap as part of the if-let above
            nameLabel.text = tool.name
            categoryLabel.text = tool.category.displayName
            secLabel.text = tool.section.displayName
            priceLabel.text = tool.price
            availabilityLabel.text = tool.availability
        }
    }

    
    @IBAction func chatButtonPressed(sender: UIButton) {
        
        // CR: Gaurd-let
        guard let user = tool.postedBy as? User,
            let currentUser = User.currentUser() else {
                
        }
        
        
        let conversationQuery = Conversation.query()!
        conversationQuery.whereKey("owner", equalTo: user)
        conversationQuery.whereKey("notOwner", equalTo: currentUser)
        conversationQuery.includeKey("tool")
        conversationQuery.includeKey("tool.postedBy")
        conversationQuery.includeKey("owner")
        conversationQuery.includeKey("notOwner")
        conversationQuery.findObjectsInBackgroundWithBlock({ (conversations, error) in
            
            if let conversations = conversations as? [Conversation],
                let conversation = conversations.first {
                
                self.performSegueWithIdentifier("goToChatViewController", sender: conversation)
                
                
            }else {
                
                let conversation = Conversation(owner: user, notOwner: currentUser, tool: self.tool)
                
                conversation.saveInBackgroundWithBlock({ (success, error) in
                    
                    self.performSegueWithIdentifier("goToChatViewController", sender: conversation)
                    
                    
                })
                
                
            }
            
            
        })
        
        
        
    }
    
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // CR: if-let instead of identifier check
        
        if let chatvc = segue.destinationViewController as? ChatViewController, let conversation = sender as? Conversation {
                chatvc.conversation = conversation
        }
        

            
//            conversation.tool = tool
//            chatvc.tool = tool
//            print("Passing item--\(chatvc.conversation)")
            
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

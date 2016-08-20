//
//  PostDispalyViewController.swift
//  LHL-Neighbourhood
//
//  Created by reena on 10/08/16.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import UIKit
import Parse

class PostDisplayViewController: UIViewController {
  
  
    @IBOutlet weak var postTitle: UITextField!


    @IBOutlet weak var postDateAndTime: UIDatePicker!
    @IBOutlet weak var postDescription: UITextView!
    @IBOutlet weak var postedByManager: UITextField!
    
    let postEventDate = NSDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func savePostButtonPressed(sender: UIButton) {
      
        let post = ManagerPost()
        post.title = self.postTitle.text ?? ""
        post.postDescription = self.postDescription.text  ?? ""
        post.managerName = self.postedByManager.text ?? ""
        post.eventDate = self.postDateAndTime.date
        
        post.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                self.showAlertOnSuccessThenDisappear("Success", message: "Post Added")
            } else {
                // There was a problem, check error.description
                self.showAlertOnError("Error", message: "Post could not be saved to the server")
            }
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func cancelPostButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func showAlertOnError(title: String, message: String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    } // CR: seriously?

    func showAlertOnSuccessThenDisappear(title: String, message: String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        self.presentViewController(alertController, animated: true, completion: nil)
        let delay = 1.9 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            alertController.dismissViewControllerAnimated(true, completion: nil)
        })

    }
    
    @IBOutlet weak var postButtonPressed: UIButton!
}

//
//  EmergencyContentViewController.swift
//  LHL-Neighbourhood
//
//  Created by reena on 10/08/16.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import UIKit
import Parse

class EmergencyContentViewController: UIViewController {
  
  
    @IBOutlet weak var postTitle: UITextField!


    @IBOutlet weak var postDateAndTime: UIDatePicker!
    
    @IBOutlet weak var postDescription: UITextView!
 
    @IBOutlet weak var postedByManager: UITextField!
    
    let postEventDate = NSDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "pat1.jpg")!).colorWithAlphaComponent(0.9)
        //datepicker value change
//        postDateAndTime.addTarget(self, action: Selector("dataPickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)

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
    }

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

//    func datePickerChanged(datePicker:UIDatePicker) {
//        var dateFormatter = NSDateFormatter()
//        
//        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
//        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
//        
//        var strDate = dateFormatter.stringFromDate(datePicker.date)
//        dateLabel.text = strDate
//    }
    
}

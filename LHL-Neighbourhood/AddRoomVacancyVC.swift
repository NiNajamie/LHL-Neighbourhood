//
//  AddRoomVacancyVC.swift
//  LHL-Neighbourhood
//
//  Created by reena on 13/08/16.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import UIKit
import Parse

class AddRoomVacancyVC: UIViewController {

    @IBOutlet weak var roomNoTextfield: UITextField!
    @IBOutlet weak var roomDetails: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func AddVacancyButtonPressed(sender: UIButton) {
        let room = PFObject(className:"VacantRoom")
        room["room"] = self.roomNoTextfield.text
        room["description"] = self.roomDetails.text
        
        room.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                self.showAlertOnSuccessThenDisappear("Success", message: "Vacancy Added")
               
            } else {
                // There was a problem, check error.description
                self.showAlertOnError("Error", message: "Post could not be saved to the server")
            }
        }
         self.dismissViewControllerAnimated(true, completion: nil)

    }
    
    @IBAction func clearFieldButtonPressed(sender: UIButton) {
        
        self.roomNoTextfield.text = ""
        self.roomDetails.text = ""
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

 
    @IBAction func cancelButtonPressed(sender: UIButton) {
         self.dismissViewControllerAnimated(true, completion: nil)
    }
}

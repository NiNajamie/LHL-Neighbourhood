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
    
    @IBOutlet weak var addRoomVacancyButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = false
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "white.jpg")!).colorWithAlphaComponent(0.9)
        navigationController!.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.whiteColor()]

        roomDetails.backgroundColor = UIColor(red: 0, green: 1, blue: 1, alpha: 0.1)
//         addRoomVacancyButton.setBackgroundImage(UIImage(named: "plus.png"), forState: UIControlState.Normal)
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

//
//  SignInViewController.swift
//  LHL-Neighbourhood
//
//  Created by Asuka Nakagawa on 2016-08-08.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import UIKit
import Parse
import DigitsKit
import IQKeyboardManagerSwift


class SignInViewController: UIViewController {
    
    
    
    @IBOutlet weak var fullnameTextfield: UITextField!
    @IBOutlet weak var userNameTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var userTypeSegmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userTypeSegmentControl.selectedSegmentIndex  = 0
        

        
        // will enable keyboard manager
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
        
    }
 //Mark: Login / Sign Up Action
    
    @IBAction func loginPressed(sender: UIButton) {
//        self.performSegueWithIdentifier("segueToLoginVC", sender: sender)
    }
    
    
    @IBAction func signUpPressed(sender: UIButton) {
        
        //CHECK IF FIELDS ARE EMPTY
        
        if (passwordTextfield.text?.characters.count == 0 || userNameTextfield.text?.characters.count == 0 || fullnameTextfield.text?.characters.count == 0){
            
            let alertController = UIAlertController(title: "Error", message:
                "Fields can not be empty!!!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        let user = PFUser()
        user.username = userNameTextfield.text!
        user.password = passwordTextfield.text!
        user["residentName"] = fullnameTextfield.text!
        
        if  self.userTypeSegmentControl.selectedSegmentIndex == 0
        {
        user["manager"] = false
        }
        else
        {
        user["manager"] = true
        }
        
        user.signUpInBackgroundWithBlock{
            (result, error) -> Void in
            if error == nil && result == true {
                print("SAVED OBJECT")
                //GO TO HOMEPAGE perform segue to Login
                   self.performSegueToHomepage()
                
            }
            else
            {
               print(error)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentPressed(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1
        {
            self.view.backgroundColor = UIColor.lightGrayColor()
        }
    }
    
    //resign as first responder
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        userNameTextfield.resignFirstResponder()
        passwordTextfield.resignFirstResponder()
    }

//    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return false
//    }
//    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func performSegueToHomepage() {
        
        performSegueWithIdentifier("segueToLoginVC", sender: self)
        }

}

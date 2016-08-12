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
        
<<<<<<< HEAD
=======

        
>>>>>>> f93a721f7734b0791dc3a0c7ddd7cf6d0b333ff2
        // will enable keyboard manager
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
        
    }
    //Mark: Login / Sign Up Action
    @IBAction func loginPressed(sender: UIButton) {
        //Perform segue on through main storyboard
    }
    
    
    @IBAction func signUpPressed(sender: UIButton) {
        
        //CHECK IF FIELDS ARE EMPTY
        
        if (passwordTextfield.text?.characters.count == 0 || userNameTextfield.text?.characters.count == 0 || fullnameTextfield.text?.characters.count == 0){
            
            self.showAlertOnError("Error", message: "Fields can not be empty!!!")
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
                self.showAlertOnSuccessThenDisappear(self.sayWelcomeUser(self.fullnameTextfield.text!),message: "Successful Login :)")
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
        if sender.selectedSegmentIndex == 0 {
            self.view.backgroundColor = UIColor.yellowColor()
        }
    }
    
    //resign as first responder
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        userNameTextfield.resignFirstResponder()
        passwordTextfield.resignFirstResponder()
    }
    
    func performSegueToHomepage() {
        performSegueWithIdentifier("segueToLoginVC", sender: self)
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
    
    func showAlertOnError(title: String, message: String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
    func sayWelcomeUser(personName: String) -> String {
        return "Welcome, \(personName)"
    }
}

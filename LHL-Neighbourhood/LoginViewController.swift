//
//  LoginViewController.swift
//  LHL-Neighbourhood
//
//  Created by reena on 10/08/16.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func loginButtonPressed(sender: UIButton) {
        //CHECK IF EMPTY
        
        if (password.text?.characters.count == 0 || userName.text?.characters.count == 0){
            
            let alertController = UIAlertController(title: "Error", message:
                "Fields can not be empty!!!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        PFUser.logInWithUsernameInBackground(userName.text!, password: password.text!) { (user, error) -> Void in
            if let loggedInUser = user
            {
                //take to homepage perform segue
                self.performSegueToHomepage()
                print("LoggedIn")
            }
            else
            {
                let alertController = UIAlertController(title: "Invalid User", message:
                    "User Doesn't Exit!!!", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            
        }
    }
    
    override  func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func performSegueToHomepage() {
        
        performSegueWithIdentifier("segueToHome", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

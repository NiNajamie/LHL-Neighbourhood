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


class SignInViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let authButton = DGTAuthenticateButton(authenticationCompletion: { (session: DGTSession?, error: NSError?) in
            if (session != nil) {
                // TODO: associate the session userID with your user model
                let message = "Phone number: \(session!.phoneNumber)"
                let alertController = UIAlertController(title: "You are logged in!", message: message, preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: .None))
                self.presentViewController(alertController, animated: true, completion: .None)
            } else {
                NSLog("Authentication error: %@", error!.localizedDescription)
            }
        })
        authButton.center = self.view.center
        self.view.addSubview(authButton)

        

//        let testObject = PFObject(className: "TestObject")
//        testObject["foo"] = "bar"
//        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
//            print("Object has been saved.")
//        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

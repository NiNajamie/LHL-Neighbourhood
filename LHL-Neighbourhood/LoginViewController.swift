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
        self.navigationItem.hidesBackButton = false
         self.navigationController?.navigationBarHidden = false
        navigationController!.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController!.navigationBar.barTintColor = UIColor(red: 0.0431, green: 0.0824, blue: 0.4392, alpha: 1.0)

        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "n3.jpg")?.drawInRect(self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image).colorWithAlphaComponent(0.9)

//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "n3.jpg")!).colorWithAlphaComponent(0.5)
        


        // Do any additional setup after loading the view.
    }

    
    @IBAction func loginButtonPressed(sender: UIButton) {
        //CHECK IF EMPTY
        
        if (password.text?.characters.count == 0 || userName.text?.characters.count == 0){
            self.showAlertOnError("Error", message: "Fields can not be empty!!!" )
        }
        
        PFUser.logInWithUsernameInBackground(userName.text!, password: password.text!) { (user, error) -> Void in
            if let loggedInUser = user
            {
                print(loggedInUser)
                
                //                var isManager = loggedInUser["manager"]
                //                if let isTrue == isManager{
                if((loggedInUser["manager"]) as! Bool == true){
                    self.performSegueTo("segueToManagerBoard")}else{
                    self.performSegueTo("segueToHome")
                }
            }
            else
            {
                self.showAlertOnError("Invalid User", message: "User Doesn't Exit - Sign Up!!!")
            }
            
        }
    }
    
    override  func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func performSegueTo(viewcontroller: String) {
        
        performSegueWithIdentifier(viewcontroller, sender: self)
    }

    
    func showAlertOnError(title: String, message: String){
    
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
 

    
    
}

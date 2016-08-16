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
    
    @IBOutlet weak var apartmentTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "neighbourhood.jpg")!).colorWithAlphaComponent(0.9)
        self.userTypeSegmentControl.selectedSegmentIndex  = 0
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
        
        if (passwordTextfield.text?.characters.count == 0 || userNameTextfield.text?.characters.count == 0 || fullnameTextfield.text?.characters.count == 0 || apartmentTextfield.text?.characters.count == 0 ){
            self.showAlertOnError("Error", message: "Fields can not be empty!!!")
        }
            //Fileds not empty
            
        else{

            if(self.userTypeSegmentControl.selectedSegmentIndex == 0){
                
                self.apartmentAlreadyExist {
                    (apartment) -> () in
                    
                    if let apartment = apartment{
                        self.saveUser(apartment, isManager: false)
                    } else {
                        self.showAlertOnError("Error", message: "Apartment does not exist")
                    }
                }
            }
            
            if(self.userTypeSegmentControl.selectedSegmentIndex == 1){
                
                self.apartmentAlreadyExist {
                    (apartment) -> () in
    
                    if apartment == nil {
                        // create an apartment, then save user
                        self.saveUser(nil,isManager: true)
                    } else {
                        self.showAlertOnError("Error", message: "Apartment Name Unavailable")
                    }
                }
            }
            
            //            else{
            //                if(self.apartmentAlreadyExist({(apartment) -> () in
            //
            //
            //
            
            //}))
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
            apartmentTextfield.placeholder = "Create Apartment"
            clearTextfields()
            
        }
        if sender.selectedSegmentIndex == 0 {
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "neighbourhood.jpg")!).colorWithAlphaComponent(0.9)
            apartmentTextfield.placeholder = "Join Apartment"
            clearTextfields()
            //self.view.backgroundColor = UIColor.yellowColor()
            
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
    
    func apartmentAlreadyExist(completion:(apt:Apartment?)-> ()) {
        let enteredApt = apartmentTextfield.text
        let apartmentExistQuery = Apartment.query()
        apartmentExistQuery!.whereKey("name",  equalTo: enteredApt!)
        apartmentExistQuery?.findObjectsInBackgroundWithBlock {(apartments, error) in
            
            if let apartment = apartments?.first as? Apartment {
                completion(apt: apartment)
            }else{
                completion(apt: nil)
            }
        }
        
    }
    
    
    
    //
    //    { (apartments, error) -> Bool in
    //    if (apartments!.count > 0) {
    //    return true
    //    }
    //    } else {
    //    return false
    //    }
    //
    //}
    
    func saveUser(apartment: Apartment?,isManager:Bool){
        var userIsTaken:Bool = false
        
        self.usernameIsTaken({(isTaken) -> () in
            userIsTaken = isTaken
            if(userIsTaken){
                //alert
                self.showAlertOnError("Invalid Username", message: "User Name is taken")
                self.clearTextfields()
            }
            else{
                let user = User()
                user.username = self.userNameTextfield.text!
                user.password = self.passwordTextfield.text!
                user["residentName"] = self.fullnameTextfield.text!
                user["manager"] = isManager
                
                let message: String
                
                if let apartment = apartment { // user is not a manager, apartment exists
                    user.apartment = apartment
                    message = "Successful signup!"
                } else {
                    
                    user.apartment = self.createApartment()
                    message = "Successful SignUp - Apartment created :)"
                }

                user.signUpInBackgroundWithBlock {
                    (result, error) -> Void in
                    if error == nil && result == true {
                        print("SAVED OBJECT")
                        //GO TO HOMEPAGE perform segue to Login
                        self.performSegueToHomepage()
                        self.showAlertOnSuccessThenDisappear(self.sayWelcomeUser(self.fullnameTextfield.text!),message: message)
                    }
                }
                
                //resident save

            }
            
        })
        
    }
    
    func createApartment() -> Apartment {
//        let userManager = PFUser()
//        userManager.username = userNameTextfield.text!
//        userManager.password = passwordTextfield.text!
//        userManager["residentName"] = fullnameTextfield.text!
//        userManager["manager"] = false
//        userManager["apartment"] = apartmentTextfield.text!
//        userManager.signUpInBackgroundWithBlock{
//            (result, error) -> Void in
//            if error == nil && result == true {
//                print("SAVED OBJECT")
//                //GO TO HOMEPAGE perform segue to Login
//                self.performSegueToHomepage()
//                self.showAlertOnSuccessThenDisappear(self.sayWelcomeUser(self.fullnameTextfield.text!),message: "Successful Login :)")
//            }
//        }
        
        let apartment = Apartment()
        apartment.name = self.apartmentTextfield.text!
        
        return apartment
        
    }
    
    func userIsManagerQuery(username:String, isManager:Bool)
    {
//        let user = PFUser()
//        let ifUserIsManager = user.query()
//        let enteredUsername = userNameTextfield.text
//      //  let isManager =
//        apartmentExistQuery!.whereKey("name",  equalTo: enteredApt!)
//        apartmentExistQuery?.findObjectsInBackgroundWithBlock {(apartments, error) in
//            
//            if let apartment = apartments?.first as? Apartment {
//                completion(apt: apartment)
//            }else{
//                completion(apt: nil)
//            }
//        }
    }
    
    func usernameIsTaken(completion:(userNameTaken:Bool)-> ()){
        
        //bool to see if username is taken
       
        let username = userNameTextfield.text!
        //access PFUsers
        var query : PFQuery = PFUser.query()!
        query.whereKey("username",  equalTo: username)
        
        query.findObjectsInBackgroundWithBlock {
            (objects, error) in
            if error == nil {
                if (objects!.count > 0){
                    completion(userNameTaken: true)
                    print("***username is taken")
                } else {
                    completion(userNameTaken: false)
                    print("****Username is available. ")
                }
            } else {
                print("error")
            }
        }
        
    }

    override func viewWillAppear(animated: Bool) {
        clearTextfields()
    }
    
    func clearTextfields(){
        fullnameTextfield.text = ""
        apartmentTextfield.text = ""
        userNameTextfield.text = ""
        passwordTextfield.text = ""
    }
}

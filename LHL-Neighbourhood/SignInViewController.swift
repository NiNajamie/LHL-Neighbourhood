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
       self.navigationController?.navigationBarHidden = true
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
            
            if (self.userTypeSegmentControl.selectedSegmentIndex == 1){
                self.apartmentAlreadyExist { apartment in
                    if let apartment = apartment {
                        self.showAlertOnError("Error", message: "Apartment Name '\(apartment.name)' Unavailable")
                    } else {
                        // create an apartment, then save user
                        self.saveUser(nil, isManager: true)
                    }
                }
            }

        }
    }
    
    @IBAction func segmentPressed(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1
        {
//             self.view.backgroundColor = UIColor(patternImage: UIImage(named: "gray.jpg")!).colorWithAlphaComponent(0.9)
//            self.view?.contentMode = UIViewContentMode.ScaleAspectFill
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
    
    func saveUser(apartment: Apartment?, isManager:Bool) {
        self.usernameIsTaken { isTaken in
            if (isTaken) {
                //alert
                self.showAlertOnError("Invalid Username", message: "User Name is taken")
                self.clearTextfields()
            } else {
                let user = User()
                user.username = self.userNameTextfield.text!
                user.password = self.passwordTextfield.text!
                user["residentName"] = self.fullnameTextfield.text!
                user["manager"] = isManager
                
                user.signUpInBackgroundWithBlock { result, error in
                    if error == nil && result == true {
                        print("user signup SAVED OBJECT")
                        
                        
                        if let apartment = apartment { // user is not a manager, apartment exists
                            user.apartment = apartment
                            let message = "Successful signup!"
                            
                            user.saveInBackgroundWithBlock { result, error in
                                //GO TO HOMEPAGE perform segue to Login
                                self.performSegueToHomepage()
                                self.showAlertOnSuccessThenDisappear(self.sayWelcomeUser(self.fullnameTextfield.text!),message: message)
                            }
                        } else {
                            //if apartment doesn't exist create
                            self.createApartmentForManager(user) { ap in
                                user.apartment = ap
                                let message = "Successful SignUp - Apartment created :)"
                                user.saveInBackgroundWithBlock { result, error in
                                self.showAlertOnSuccessThenDisappear(self.sayWelcomeUser(self.fullnameTextfield.text!),message: message)
                                }
                            }
                            self.performSegueToHomepage()
                        }
                    }
                }
            }
        }
        
       
    }
    
    func createApartmentForManager(user:User, completion:(Apartment)->()) {
        let apartment = Apartment()
        apartment.name = self.apartmentTextfield.text!
        apartment.saveInBackgroundWithBlock { success, error in
            if (success) {
                apartment.user = user
                apartment.saveInBackgroundWithBlock { success, error in
                    completion(apartment)
                    self.showAlertOnSuccessThenDisappear("Success", message: "Manager Sign-Up successful")
                }
            } else {
                // There was a problem, check error.description
                self.showAlertOnError("Error", message: "Account could not be created")
            }
        }
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
        let query : PFQuery = PFUser.query()!
        query.whereKey("username",  equalTo: username)
        
        query.findObjectsInBackgroundWithBlock { objects, error in
            if let error = error {
                print(error)
            } else {
                if (objects!.count > 0){
                    completion(userNameTaken: true)
                    print("***username is taken")
                } else {
                    completion(userNameTaken: false)
                    print("****Username is available. ")
                }
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
//extension UIView {
//    func addBackground(image: String) {
//        // screen width and height:
//        let width = UIScreen.mainScreen().bounds.size.width
//        let height = UIScreen.mainScreen().bounds.size.height
//        
//        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, width, height))
//        imageViewBackground.image = UIImage(named: image)
//        
//        // you can change the content mode:
//        imageViewBackground.contentMode = UIViewContentMode.ScaleAspectFill
//        
//        self.addSubview(imageViewBackground)
//        self.sendSubviewToBack(imageViewBackground)
//    }}
//


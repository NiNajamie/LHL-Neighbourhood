//
//  AddToolViewController.swift
//  LHL-Neighbourhood
//
//  Created by Asuka Nakagawa on 2016-08-11.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import UIKit
import Parse
import IQKeyboardManagerSwift


class AddToolViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var categoryPickerView: UIPickerView!
    
    @IBOutlet weak var availabilityTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    
    // List for pickerViews
    var catSecList = [
        ["Kitchen", "Outdoor", "Electronics", "Garden", "Miscellaneous"],
        ["Share", "Buy", "Sell"]
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        
        // will enable keyboard manager
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true

        let tapGesture = UITapGestureRecognizer(target:self, action: #selector(AddToolViewController.imageViewTapped(_:)))
        tapGesture.delegate = self
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        nameTextField.resignFirstResponder()
        availabilityTextField.resignFirstResponder()
        priceTextField.resignFirstResponder()
    }

    // MARKS: Action - imageViewTapped -
    func imageViewTapped(sender: UITapGestureRecognizer? = nil) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        if TARGET_OS_SIMULATOR == 1 {
            
            imagePickerController.sourceType = .PhotoLibrary
            
        } else {
            
            imagePickerController.sourceType = .Camera
            imagePickerController.cameraDevice = .Rear
            imagePickerController.cameraCaptureMode = .Photo
        }
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.image = selectedImage
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func savePressed(sender: UIBarButtonItem) {
        
        if (PFUser.currentUser() == nil) {
            print("User is nil")
        }
        
        let tool = PFObject(className: "Tool")
        
        tool["name"] = nameTextField.text
        tool["postedBy"] = PFUser.currentUser()
        tool["category"] = catSecList[0][categoryPickerView.selectedRowInComponent(0)]
        tool["sectionStr"] = catSecList[1][categoryPickerView.selectedRowInComponent(1)]
        tool["availability"] = availabilityTextField.text
        tool["price"] = priceTextField.text

        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.9)
        let imageFile = PFFile(data: imageData!)
        tool["photo"] = imageFile
        
        tool.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                print("Tool has been sucessfully saved!")
            } else {
                // There was a problem, check error.description
                print("Error!")
                print(error!.description)
            }
        }
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    @IBAction func cancelPressed(sender: UIBarButtonItem) {
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    
    
    //MARK: - UIPickerView Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return catSecList.count
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return catSecList[component].count
        
    }
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return catSecList[component][row]
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

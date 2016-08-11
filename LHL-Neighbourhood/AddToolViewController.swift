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


class AddToolViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var categoryPickerView: UIPickerView!
    
    @IBOutlet weak var availabilityTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    
    // For pickerViews
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

    }

    
    
    @IBAction func savePressed(sender: UIBarButtonItem) {
        
        let tool = PFObject(className: "Tool")
        
        tool["name"] = nameTextField.text
        //        tool["photo"] = " "
        //        tool["postedBy"] = PFUser.currentUser()
        tool["category"] = catSecList[0][categoryPickerView.selectedRowInComponent(0)]
        tool["sectionStr"] = catSecList[1][categoryPickerView.selectedRowInComponent(1)]
        tool["availability"] = availabilityTextField.text
        tool["price"] = priceTextField.text
        
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
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        nameTextField.resignFirstResponder()
        availabilityTextField.resignFirstResponder()
        priceTextField.resignFirstResponder()

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

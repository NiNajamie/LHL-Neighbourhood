//
//  VacantRoomDetailVC.swift
//  LHL-Neighbourhood
//
//  Created by reena on 17/08/16.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import UIKit
import Parse

class VacantRoomDetailVC: UIViewController {
 var room: VacantRoom!
//
//    @IBOutlet weak var descriptionTextfield: UITextField!
//    @IBOutlet weak var roomDescription: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var roomNo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        //        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "white.jpg")!).colorWithAlphaComponent(0.9)
        navigationController!.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController!.navigationBar.barTintColor = UIColor(red: 0.0431, green: 0.0824, blue: 0.4392, alpha: 1.0)
//        UIGraphicsBeginImageContext(self.view.frame.size)
//        UIImage(named: "white.jpg")?.drawInRect(self.view.bounds)
//        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        self.view.backgroundColor = UIColor(patternImage: image).colorWithAlphaComponent(0.9)
        roomNo.text = room.room
        descTextView.text = room.roomInfo
       // print(room.roomDetails)

    }
    @IBAction func cancelButtonPressed(sender: UIButton) {
     self.dismissViewControllerAnimated(true, completion: nil)
    }
}

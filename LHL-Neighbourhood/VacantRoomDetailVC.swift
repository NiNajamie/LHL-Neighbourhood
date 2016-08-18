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
    
    @IBOutlet weak var roomDescription: UILabel!
    @IBOutlet weak var roomNo: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "white.jpg")?.drawInRect(self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image).colorWithAlphaComponent(0.9)
        roomNo.text = room.room
        roomDescription.text = room.roomDetails

    }
    @IBAction func cancelButtonPressed(sender: UIButton) {
     self.dismissViewControllerAnimated(true, completion: nil)
    }
}

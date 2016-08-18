//
//  ManagerBoardVC.swift
//  LHL-Neighbourhood
//
//  Created by reena on 16/08/16.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import UIKit
import Parse
class ManagerBoardVC: UIViewController {
    
    @IBOutlet weak var noticeBoardButton: UIButton!
    
    @IBOutlet weak var updateVacancyButton: UIButton!
    
var managerBoardLabel: String!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "white2.jpg")!).colorWithAlphaComponent(0.9)
        self.navigationController?.navigationBarHidden = false
//        let navBackgroundImage:UIImage! = UIImage(named: "blackpat.png")
//        UINavigationBar.appearance().setBackgroundImage(navBackgroundImage, forBarMetrics: .Default)
        
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "white1.jpg")!).colorWithAlphaComponent(0.9)
//        noticeBoardButton.setBackgroundImage(UIImage(named: "notice.jpg"), forState: UIControlState.Normal)
//        updateVacancyButton.setBackgroundImage(UIImage(named: "r1.png"), forState: UIControlState.Normal)
        setNavigationBarTitle()
        
    }
    
    @IBAction func communityButtonPressed(sender: UIButton) {
//        
//            performSegueWithIdentifier("managerBoardToHome", sender: self)

    }
    func setNavigationBarTitle(){
        if let user = User.currentUser(){
            if let userName = user.username{
                managerBoardLabel = "Welcome Manager, \(userName)"
                print(userName)}
            
            self.navigationItem.title = managerBoardLabel
        }
    }
    
}

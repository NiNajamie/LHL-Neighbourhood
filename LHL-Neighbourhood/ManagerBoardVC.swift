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
        self.navigationController?.navigationBarHidden = false

        setNavigationBarTitle()
    }
    
    @IBAction func communityButtonPressed(sender: UIButton) {
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

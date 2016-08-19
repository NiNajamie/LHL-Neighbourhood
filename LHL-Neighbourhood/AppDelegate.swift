//
//  AppDelegate.swift
//  LHL-Neighbourhood
//
//  Created by Asuka Nakagawa on 2016-08-08.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import UIKit
import Parse
import Fabric
import DigitsKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
       registerParseClasses()
        //initialsize Parse
        UIApplication.sharedApplication().statusBarStyle = .LightContent

        Parse.setApplicationId("630Hhc8GeD5A7Oj9PUu6s7aiBLzPcWT6X8MPCgEI", clientKey: "qIkc16ORUw7L5D42pZF6JZagB6PiKEMgakAt0P0U")

        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
   
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
       
    }

    func applicationDidBecomeActive(application: UIApplication) {
      
    }

    func applicationWillTerminate(application: UIApplication) {
      
    }
    
    func registerParseClasses(){
        Apartment.registerSubclass()
        User.registerSubclass()
        TextMessage.registerSubclass()
        ManagerPost.registerSubclass()
        VacantRoom.registerSubclass()
        Tool.registerSubclass()
        Section.registerSubclass()
        Category.registerSubclass()
        Conversation.registerSubclass()
        }

}


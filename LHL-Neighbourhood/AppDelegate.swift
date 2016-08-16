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
        
        // Initialize Parse.
        User.registerSubclass()
        TextMessage.registerSubclass()
        ManagerPost.registerSubclass()
        VacantRoom.registerSubclass()
        Tool.registerSubclass()
        Section.registerSubclass()
        Category.registerSubclass()
        
        Conversation.registerSubclass()
        
        Parse.setApplicationId("630Hhc8GeD5A7Oj9PUu6s7aiBLzPcWT6X8MPCgEI", clientKey: "qIkc16ORUw7L5D42pZF6JZagB6PiKEMgakAt0P0U")
        
        //Fabric
//        Fabric.with([Digits.self])
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle());
        let currentUser = PFUser.currentUser()
        print(currentUser)
        if currentUser != nil {
            self.window?.rootViewController = storyboard.instantiateViewControllerWithIdentifier("BoardViewController");
        }

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


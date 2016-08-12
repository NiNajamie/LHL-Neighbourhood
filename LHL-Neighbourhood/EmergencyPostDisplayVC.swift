//
//  EmergencyPostDisplayVC.swift
//  LHL-Neighbourhood
//
//  Created by reena on 10/08/16.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import UIKit
//
//class EmergencyPostDisplayVC: UIViewController, UIPageViewControllerDataSource{
//    
//    // MARK: - Variables
////    private var pageViewController: UIPageViewController?
//
//    var pageViewController:UIPageViewController!
//    var pageTitles:NSArray!
//    var pageDetails:NSArray!
//    var pages
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.pageTitles = NSArray(objects: "Explore", "Don't Explore")
//        self.pageDetails = NSArray(objects: "Wow it isn't set to nil now", "Wanna see this Page")
//        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageController") as! UIPageViewController
//        
//        self.pageViewController.dataSource = self
//        let startVC = self.viewControllerAtIndex(0) as EmergencyContentViewController
//        
//      //array holding our first VC
//        let viewControllers = NSArray(objects: startVC)
//        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
//        
//        
//        self.pageViewController.view.frame = CGRectMake(0, 30, self.view.frame.width, self.view.frame.height-60)
//        self.addChildViewController(self.pageViewController)
//        self.view.addSubview(self.pageViewController.view)
//        self.pageViewController.didMoveToParentViewController(self)
//    }
//
//    @IBAction func AddEmergencyPostButtonPressed(sender: AnyObject) {
//        
//    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    func viewControllerAtIndex(index: Int) -> EmergencyContentViewController
//    {
//        if ((self.pageTitles.count == 0) || (index >= self.pageTitles.count)) {
//         return EmergencyContentViewController()
//        }
//        
//        let vc: UIPageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageController") as! EmergencyContentViewController
//        vc.titleText = self.pageTitles[index]as! String
//        vc.pageIndex = index
//        return vc
//    }
//    
//    
//    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
//        let vc = viewController as! EmergencyContentViewController
//        var index = vc.pageIndex as Int
//        if (index == 0 || index == NSNotFound)
//        {
//            
//            return nil
//        }
//        
//        index -= 1
//        
//        return self.viewControllerAtIndex(index)
//        }
//
//    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
//        let vc = viewController as! EmergencyContentViewController
//        var index = vc.pageIndex as Int
//        if (index == NSNotFound) {
//            return nil
//        }
//        index += 1
//        if (index == self.pageTitles.count) {
//           
//        }
//        return self.viewControllerAtIndex(index)
//    }
//    
//    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return self.pageTitles.count
//    }
//    
//    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return 0
//    }
//
//}

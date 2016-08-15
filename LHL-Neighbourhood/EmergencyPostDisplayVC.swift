//
//  EmergencyPostDisplayVC.swift
//  LHL-Neighbourhood
//
//  Created by reena on 10/08/16.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import UIKit
import Parse

class EmergencyPostDisplayVC: UIViewController, UIPageViewControllerDataSource{
    
    // MARK: - Variables
    var pageViewController: UIPageViewController?
    
    // Initialize it right away here
  //  var postArra = [ManagerPost]()
    
    var postArray = [ManagerPost]()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        fetchFromParse({
//            postArray in
            self.postArray = [ManagerPost]()

//        })
        fetchFromParse()
        createPageViewController()
        setupPageControl()
    }
    
    func createPageViewController() {
        
        let pageController = self.storyboard!.instantiateViewControllerWithIdentifier("PageController") as! UIPageViewController
        pageController.dataSource = self
        
        if postArray.count > 0 {
            let firstController = getItemController(0)!
            let startingViewControllers = [firstController]
            pageController.setViewControllers(startingViewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        }
        
        pageViewController = pageController
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
    }
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.grayColor()
        appearance.currentPageIndicatorTintColor = UIColor.whiteColor()
        appearance.backgroundColor = UIColor.darkGrayColor()
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        guard let itemController = viewController as? PostContentViewController else { return nil }
        
        if itemController.itemIndex > 0 {
            return getItemController(itemController.itemIndex-1)
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        guard let itemController = viewController as? PostContentViewController else { return nil }
        
        if itemController.itemIndex+1 < postArray.count {
            return getItemController(itemController.itemIndex+1)
        }
        
        return nil
    }
    
    private func getItemController(itemIndex: Int) -> PostContentViewController? {
        
        if itemIndex < postArray.count {
            let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier("PageContent") as! PostContentViewController
            let aPost = postArray[itemIndex]
//            pageItemController.itemIndex = itemIndex
//            pageItemController.postTitle = aPost.title
//            pageItemController.postedBy = aPost.managerName
//            pageItemController.postDate = aPost.eventDate.description
//            pageItemController.postDescription = aPost.description
            
            return pageItemController
        }
        
        return nil
    }
    
    // MARK: - Page Indicator
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        
        return postArray.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    // MARK: - Additions
    
    func currentControllerIndex() -> Int {
        
        let pageItemController = self.currentController()
        
        if let controller = pageItemController as? PostContentViewController {
            return controller.itemIndex
        }
        
        return -1
    }
    
    func currentController() -> UIViewController? {
        
        if self.pageViewController?.viewControllers?.count > 0 {
            return self.pageViewController?.viewControllers![0]
        }
        
        return nil
    }
    
 func fetchFromParse() {
        let query = PFQuery(className:"ManagerPost")
        query.findObjectsInBackgroundWithBlock { (posts, error) -> Void in
            if error == nil {
         
                for post in posts! {
                    self.postArray.append(post as! ManagerPost)
                }
                self.pageViewController?.loadView()
            
//                dispatch_async(dispatch_get_main_queue()) {
//                completion(postArray: self.postArray)
////                    self.pageViewController?.reloadInputViews()
//
//                }

            } else {
                print(error)
            }
        }
        print("Last \(self.postArray.count)")

    }


}
//
//  MainVC.swift
//  LHL-Neighbourhood
//
//  Created by reena on 14/08/16.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import UIKit
import Parse

class MainVC: UIPageViewController, UIPageViewControllerDataSource {

    var postArray = [ManagerPost]()
private var pageViewController: UIPageViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFromParse { (success) in
            self.setViewControllers([self.getViewControllerAtIndex(0)] as [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
            self.navigationItem.title = "\(self.postArray.count) Notices"
        }
        
        self.dataSource = self
        self.setViewControllers([self.getViewControllerAtIndex(0)] as [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
    {
        let pageContent: PostContentViewController = viewController as! PostContentViewController
        if var index = pageContent.pageIndex {
            
            index += 1;
            if (index == postArray.count)
            {
                return nil;
            }
            return getViewControllerAtIndex(index)
            
        }else {
            return nil;
        }
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
        let pageContent: PostContentViewController = viewController as! PostContentViewController
        
        guard var index = pageContent.pageIndex where index > 0 else {
            return nil

        }
        
        index -= 1;
        
        return getViewControllerAtIndex(index)
    }
    
    func getViewControllerAtIndex(index: NSInteger) -> PostContentViewController
    {
        // Create a new view controller and pass suitable data.
        let pageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageContent") as! PostContentViewController
        
        if postArray.count == 0 {
            pageContentViewController.pageIndex = 0
            return pageContentViewController
        }else {
            let post = postArray[index]
            
            pageContentViewController.setPost(post, pageIndex: index)
            return pageContentViewController
        }
        
        
    }
    
    func fetchFromParse(completion:(success:Bool) -> ()) {
        let query = ManagerPost.query()!
        query.findObjectsInBackgroundWithBlock { (posts, error) -> Void in
            if error == nil {
                if let posts = posts as? [ManagerPost]{
                    self.postArray = posts
                    completion(success: true)
                }
                
            } else {
                print(error)
            }
        }
    }
    

    // MARK: - Page Indicator
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
       return self.postArray.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
 
}

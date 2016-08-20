//
//  PostDetailViewController.swift
//  LHL-Neighbourhood
//
//  Created by reena on 11/08/16.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import UIKit
import Parse

class PostDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var postArray = [ManagerPost]()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchFromParse()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
    return 1 // CR: not needed, default is 1.
    }
    
    //Mark: TableView DataSource and Delegate methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.postArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! Cell
        let aPost = postArray[indexPath.row]
        cell.titleLabel.text = aPost.title
        cell.postManager.text = aPost.managerName
        return cell
    }

    func fetchFromParse() {
        let query = PFQuery(className:"ManagerPost")
        query.findObjectsInBackgroundWithBlock { (posts, error) -> Void in
            
            if let posts = posts {
                for post in posts {
                    self.postArray.append(post as! ManagerPost)
                }
                self.navigationItem.title = "\(self.postArray.count) Posts"
                self.tableView.reloadData()
            } else {
                print(error)
            }
            
            if error == nil { // CR: if-let posts rather than checking error.
                for post in posts! {
                    self.postArray.append(post as! ManagerPost)
                }
                self.navigationItem.title = "\(self.postArray.count) Posts"
                self.tableView.reloadData()
            } else {
                print(error)
            }
        }
    }
}

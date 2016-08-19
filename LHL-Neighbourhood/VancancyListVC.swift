//
//  VancancyListVC.swift
//  LHL-Neighbourhood
//
//  Created by reena on 13/08/16.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import UIKit
import Parse

class VancancyListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var vacancyArray = [VacantRoom]()
 
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = false
        self.fetchFromParse()
        tableView.backgroundView = UIImageView(image: UIImage(named: "butterfly.jpg"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: TableView DataSource and Delegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.vacancyArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("VacancyCell", forIndexPath: indexPath) as! VacancyCell
        let room = vacancyArray[indexPath.row]
        //cell.textLabel?.text = room.room
        
       cell.roomLabel.text = room.room
        return cell
    }
    
    func fetchFromParse() {
        let query = PFQuery(className:"VacantRoom")
        query.findObjectsInBackgroundWithBlock { (rooms, error) -> Void in
            if error == nil {
                for room in rooms! {
                    self.vacancyArray.append(room as! VacantRoom)
                }
                self.tableView.reloadData()
            } else {
                print(error)
            }
        }
    }

    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if let destinationvc = segue.destinationViewController as? VacantRoomDetailVC,
            let indexPath = tableView.indexPathForSelectedRow {
            let room = vacancyArray[indexPath.row]
            destinationvc.room = room
        }
    }

}

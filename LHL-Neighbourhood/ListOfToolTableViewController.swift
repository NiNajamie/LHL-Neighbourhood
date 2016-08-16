//
//  ListOfToolTableViewController.swift
//  LHL-Neighbourhood
//
//  Created by Asuka Nakagawa on 2016-08-09.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import UIKit
import Parse

class ListOfToolTableViewController: UITableViewController {

    var sectionKey: String!
    
    // when tools called, updated everytime
    var tools = [Tool]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sectionQuery = Section.query()!.whereKey("key", equalTo: self.sectionKey)
        
        // we have to specify which item we needed
        // includeKeys can fetch items (better finish before nextVC loaded)
        
        
        let toolQuery = Tool.query()
        toolQuery?.whereKey("section", matchesQuery: sectionQuery)
        toolQuery?.includeKeys(["category", "section", "postedBy"])
        toolQuery?.findObjectsInBackgroundWithBlock({ (tools, error) in
            if let tools = tools as? [Tool] {
                self.tools = tools
            }
        })


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tools.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ToolCell", forIndexPath: indexPath)
        cell.textLabel?.text = tools[indexPath.row].name
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if let dvc = segue.destinationViewController as? DetailOfToolViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            
            let tool = self.tools[indexPath.row]
            dvc.tool = tool
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
}

//
//  ListConversationTableViewController.swift
//  LHL-Neighbourhood
//
//  Created by Asuka Nakagawa on 2016-08-17.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import UIKit
import Parse

class ListConversationTableViewController: UITableViewController {

    
    var conversations = [Conversation]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let currentUser = User.currentUser(), let queryOwner = Conversation.query(), let queryNotOwner = Conversation.query() else {
            return
        }
        
        queryOwner.whereKey("owner", equalTo: currentUser)
        queryNotOwner.whereKey("notOwner", equalTo: currentUser)
        
        
        let query = PFQuery.orQueryWithSubqueries([queryNotOwner, queryOwner])
        
//        let query = TextMessage.query()!
//        query.whereKey("conversation", equalTo: conversation)
        query.includeKeys(["tool", "owner", "notOwner"])
        
        query.findObjectsInBackgroundWithBlock {(conversations, error) -> Void in

            if let conversations = conversations as? [Conversation] {
                self.conversations = conversations
            }
        }
    }


    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ConversationCell", forIndexPath: indexPath)

        
        let conversation = conversations[indexPath.row]
        
        cell.detailTextLabel?.text = conversation.tool.name
        
//        cell.detailTextLabel?.text = conversation.owner.username! + " talking to " + conversation.owner.username!
        
         //conversation.tool.category

        if conversation.owner == User.currentUser() {
            cell.textLabel?.text = /*"\(conversation.tool.category.displayName) to" +*/ conversation.notOwner.username!
        } else {
            cell.textLabel?.text = /*"\(conversation.tool.category.displayName) from" +*/ conversation.owner.username!
        }
        return cell
    }
    
//            cell.detailTextLabel?.text = "Selling to " + conversation.notOwner.username!
//        } else {
//            cell.detailTextLabel?.text = "Buying from " + conversation.owner.username!

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let chatvc = segue.destinationViewController as? ChatViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            
            let conversation = self.conversations[indexPath.row]
            
            chatvc.conversation = conversation
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

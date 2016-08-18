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
        query.includeKeys(["tool", "owner", "notOwner"])
        query.findObjectsInBackgroundWithBlock {(conversations, error) -> Void in

            if let conversations = conversations as? [Conversation] {
                self.conversations = conversations
                
                // Find "userA talking to userA" and remove it from the list
                for i in 0..<self.conversations.count {

                    if self.conversations[i].notOwner.username! == self.conversations[i].owner.username! {
//                        if let index = self.conversations.indexOf(self.conversations[i]) {
                            self.conversations.removeAtIndex(i)
                            break
//                        }
                    }
                }
                
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
         //conversation.tool.category

        if conversation.owner == User.currentUser() {
            
            cell.textLabel?.font.fontWithSize(10)
            cell.textLabel?.text = conversation.notOwner.username! + " talking to " + conversation.owner.username!
            
//            cell.textLabel?.text = /*"\(conversation.tool.category.displayName) to" +*/ conversation.notOwner.username!
        } else {
            cell.textLabel?.font.fontWithSize(10)
            cell.textLabel?.text = conversation.owner.username! + " talking to " + conversation.notOwner.username!
//            cell.textLabel?.text = /*"\(conversation.tool.category.displayName) from" +*/ conversation.owner.username!
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
}
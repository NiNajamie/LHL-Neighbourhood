//
//  ChatViewController.swift
//  LHL-Neighbourhood
//
//  Created by Asuka Nakagawa on 2016-08-09.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import UIKit
import Parse
import JSQMessagesViewController


class ChatViewController: JSQMessagesViewController {
    
    // Owner's comment
    let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor(red: 10/255, green: 180/255, blue: 230/255, alpha: 1.0))
    
    // notOwner's comment
    let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor.lightGrayColor())
    
    //  To store messages sent and received in Parse
    var messages = [TextMessage]()
//    var messages = [JSQMessage]()
    
    
//    var tool: Tool!
    
    var conversation:Conversation!

    
    // currentUser == receiver
//    var applicant = User.currentUser()
    

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()

        
        // LEFT SIDE == receiver
        // Set title with Poster name
        if let postedBy = conversation.tool.postedBy {
            if let title1 = postedBy.username {
                title = title1
            }
        }
        getMessages()
        
    }
    
    // MARK: - Parse
    func getMessages() {
        let query = TextMessage.query()!
        query.whereKey("conversation", equalTo: conversation)
        query.includeKey("sender")
        query.findObjectsInBackgroundWithBlock {(messages, error) -> Void in
            
            if let messages = messages as? [TextMessage] {
                
                self.messages = messages
                self.collectionView.reloadData()
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}

//MARK - Setup
extension ChatViewController {
    
    func setup() {
        let user = User.currentUser()
        self.senderId = user!.objectId! as String
        self.senderDisplayName = user?.username
        
//        self.senderId = UIDevice.currentDevice().identifierForVendor?.UUIDString
//        self.senderDisplayName = UIDevice.currentDevice().identifierForVendor?.UUIDString
    }
}

//MARK - Data Source
extension ChatViewController {
    // how many messages we have (we return message count inside our array)
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    // which message to display where
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        
        let msg = self.messages[indexPath.row]
        let jsq = JSQMessage(senderId: msg.sender.objectId, displayName: msg.sender.username, text: msg.text)
        
        return jsq
    }
    
    // what to do when a message is deleted (delete if from messages array)
    override func collectionView(collectionView: JSQMessagesCollectionView!, didDeleteMessageAtIndexPath indexPath: NSIndexPath!) {
        self.messages.removeAtIndex(indexPath.row)
    }
    
    // which bubble to choose (outgoing if we are the sender, and incoming otherwise)
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        let data = messages[indexPath.row]
        
        switch data.sender.username! {
        case self.senderId! :
            print(data.sender.username, self.senderId!)
            return self.incomingBubble
        default:
            return self.outgoingBubble
        }
//        switch(data.senderId) {
//        case self.senderId:
//            return self.outgoingBubble
//        default:
//            return self.incomingBubble
//        }
    }
    // what to use as an avatar (for now we'll return nil and will not show avatars yet)
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    // functions returns sender display name for each message bubble - it will be used to show who sent each message.
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
        let data = self.collectionView(self.collectionView, messageDataForItemAtIndexPath: indexPath)
        if (self.senderDisplayName == data.senderDisplayName()) {
            return nil
        }
        return NSAttributedString(string: data.senderDisplayName())
    }
    
    // functions defines height of the label with sender display name.
    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        let data = self.collectionView(self.collectionView, messageDataForItemAtIndexPath: indexPath)
        if (self.senderDisplayName == data.senderDisplayName()) {
            return 0.0
        }
        return kJSQMessagesCollectionViewCellLabelHeightDefault
    }
    
}

//MARK - Toolbar
extension ChatViewController {
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        
        
        let message = TextMessage(text: text, sender: User.currentUser(), conversation: conversation)
        
        if let msg = message {
            // Add a messageObject into array
//            conversation.messageArray.addObject(msg)
            
            msg.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    // The object has been saved.
                    print("Successfully Saved!")
                } else {
                    // There was a problem, check error.description
                    print("Error for saving")
                }
            }
            self.getMessages()
        }
        
        
//        self.sendMessageToParse(message!)
        self.finishSendingMessage()
    }
//    // will do nothing, but it will prevent the app from crashing.
    override func didPressAccessoryButton(sender: UIButton!) {
    }
}


////MARK - Parse
//extension ChatViewController {
//    
//    // Saving msg into Parse
//    func sendMessageToParse(message: TextMessage) {
//        
//        let messageToSend = TextMessage()
//        messageToSend.text = message.text
//        messageToSend.sender = message.sender
//        messageToSend.receiver = message.receiver
//        messageToSend.conversation = message.conversation
//
//        messageToSend.saveInBackgroundWithBlock {
//            (success: Bool, error: NSError?) -> Void in
//            if (success) {
//                // The object has been saved.
//                print("Successfully Saved!--\(messageToSend.text)")
//            } else {
//                // There was a problem, check error.description
//                print("Error for saving")
//            }
//        }
//    }
//
//    
//}

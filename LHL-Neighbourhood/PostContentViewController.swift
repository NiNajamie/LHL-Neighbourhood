//
//  PostContentViewController.swift
//  LHL-Neighbourhood
//
//  Created by reena on 12/08/16.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import UIKit
import Parse

class PostContentViewController: UIViewController {
    
    var itemIndex: Int = 0
    var pageIndex: Int?
    var post:ManagerPost? = nil
    
    @IBOutlet weak var postedByLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
  
    @IBOutlet weak var postDescriptionTextView: UITextView!
    
    override func viewDidLoad() {
      super.viewDidLoad()
        
        if let post = post {
            postTitleLabel.text = post.title
            postDateLabel.text = post.eventDate.description
            postedByLabel.text = post.managerName
            postDescriptionTextView.text = post.postDescription
        }

        
    }
    
    func setPost(post:ManagerPost, pageIndex:Int){
        self.post = post
        self.pageIndex = pageIndex
    }
    
    
    func clearBackground(){
        postDescriptionTextView.backgroundColor = UIColor.clearColor()
        postTitleLabel.backgroundColor = UIColor.clearColor()
        postDateLabel.backgroundColor = UIColor.clearColor()
        postedByLabel.backgroundColor = UIColor.clearColor()
        postDescriptionTextView.textColor = UIColor.blackColor()
        postTitleLabel.backgroundColor = UIColor(red: 0.0431, green: 0.0824, blue: 0.4392, alpha: 1.0)

        postDateLabel.backgroundColor = UIColor(red: 0.0431, green: 0.0824, blue: 0.4392, alpha: 1.0)

        postedByLabel.backgroundColor = UIColor(red: 0.0431, green: 0.0824, blue: 0.4392, alpha: 1.0)

        
    
    }
   }

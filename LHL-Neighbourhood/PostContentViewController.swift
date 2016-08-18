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
    @IBOutlet weak var postDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
      super.viewDidLoad()
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "cube.jpg")?.drawInRect(self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image).colorWithAlphaComponent(0.9)
        postDescriptionLabel.alpha = 0.4;
        //postDescriptionLabel.backgroundColor = UIColor.clearColor()
        
        if let post = post {
            postTitleLabel.text = post.title
            postDateLabel.text = post.eventDate.description
            postedByLabel.text = post.managerName
            postDescriptionLabel.text = post.postDescription
        }

        
    }
    
    func setPost(post:ManagerPost, pageIndex:Int){
        self.post = post
        self.pageIndex = pageIndex
    }
    
   }

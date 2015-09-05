//
//  FeedViewController.swift
//  Lookie!
//
//  Created by PATRICK PERINI on 8/20/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import UIKit

class FeedViewController: UITableViewController {
    // MARK: Properties
    private var posts: [Post] = []
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsets(top: 20.0, left: 0, bottom: 110.0, right: 0)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.reloadData()
    }
    
    // MARK: Data Handlers
    func reloadData() {
        User.currentUser()?.feed({ (posts: [Post]) -> Void in
            self.posts = posts
            self.tableView.reloadData()
        })
    }
    
    func likeButtonWasPressed(sender: Button!) {
        let post = (sender.associatedObject as! [AnyObject]).first as! Post
        let likesLabel = (sender.associatedObject as! [AnyObject]).last as! UILabel
        
        let like = Like(post: post, user: User.currentUser()!)
        
        sender.enabled = false
        like.saveInBackgroundWithBlock { (success: Bool, error: NSError?) in
            if success {
                sender.setImage(UIImage(named: "heart-on"), forState: .Normal)
                sender.enabled = false
                
                let likeCount = (likesLabel.text as NSString!).integerValue + 1
                likesLabel.text = "\(likeCount)"
            } else {
                sender.setImage(UIImage(named: "heart-off"), forState: .Normal)
                sender.enabled = true
            }
        }
    }
}

extension FeedViewController { // UITableViewDataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as UITableViewCell!
        let post = self.posts[indexPath.row]
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        imageView.setImageWithURL(post.imageURL)
        
        let titleLabel = cell.viewWithTag(2) as! UILabel
        titleLabel.text = post.title
        
        let authorLabel = cell.viewWithTag(3) as! UILabel
        post.author { (user: User) in
            authorLabel.text = "by \(user.emoji) \(user.name)"
        }
        
        let likesLabel = cell.viewWithTag(4) as! UILabel
        let likeButton = cell.viewWithTag(5) as! Button
        
        post.likes { (likes: [Like]) in
            likesLabel.text = "\(likes.count)"
            
            let likedByUser = likes.filter({ $0.user == User.currentUser()!.username! }).count > 0
            if likedByUser {
                likeButton.setImage(UIImage(named: "heart-on"), forState: .Normal)
                likeButton.enabled = false
            } else {
                likeButton.setImage(UIImage(named: "heart-off"), forState: .Normal)
                likeButton.enabled = true
            }
            
            likeButton.associatedObject = [post, likesLabel]
            likeButton.addTarget(self,
                action: "likeButtonWasPressed:",
                forControlEvents: .TouchUpInside)
        }
        
        return cell
    }
}
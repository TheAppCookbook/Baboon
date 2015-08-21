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
}

extension FeedViewController: UITableViewDataSource {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! UITableViewCell
        let post = self.posts[indexPath.row]
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        imageView.setImageWithURL(post.imageURL)
        
        let titleLabel = cell.viewWithTag(2) as! UILabel
        titleLabel.text = post.title
        
        let authorLabel = cell.viewWithTag(3) as! UILabel
        post.author { (user: User) in
            authorLabel.text = "by \(user.emoji) \(user.name)"
        }
        
        return cell
    }
}
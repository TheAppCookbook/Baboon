//
//  FamilyMembersViewController.swift
//  Lookie!
//
//  Created by PATRICK PERINI on 8/20/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import UIKit

class FamilyMembersViewController: UITableViewController {
    // MARK: Properties
    @IBOutlet var userSearchField: UITextField!
    
    var familyMembers: [User] = []
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorInset = UIEdgeInsets()
        self.tableView.layoutMargins = UIEdgeInsets()
        
        self.reloadData()
    }
    
    // MARK: Data Handlers
    func reloadData() {
        if let user = User.currentUser() {
            user.familyMembers { (familyMembers: [User]) in
                self.familyMembers = familyMembers
                self.tableView.reloadData()
            }
        }
    }
}

extension FamilyMembersViewController: UITableViewDataSource {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.familyMembers.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserCell") as! UITableViewCell
        let user = self.familyMembers[indexPath.row]
        
        let emojiLabel = cell.viewWithTag(1) as! UILabel
        emojiLabel.text = user.emoji
        
        let nameLabel = cell.viewWithTag(2) as! UILabel
        nameLabel.text = user.name
        
        return cell
    }
}

extension FamilyMembersViewController: UITableViewDelegate {
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsets()
        cell.layoutMargins = UIEdgeInsets()
    }
}

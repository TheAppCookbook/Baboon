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
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorInset = UIEdgeInsets()
        self.tableView.layoutMargins = UIEdgeInsets()
    }
}

extension FamilyMembersViewController: UITableViewDataSource {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserCell") as! UITableViewCell
        return cell
    }
}

extension FamilyMembersViewController: UITableViewDelegate {
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsets()
        cell.layoutMargins = UIEdgeInsets()
    }
}

//
//  FamilyViewController.swift
//  Lookie!
//
//  Created by PATRICK PERINI on 8/20/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import UIKit

class FamilyViewController: UIViewController {
    // MARK: Properties
    @IBOutlet var instructionTopConstraint: NSLayoutConstraint!
    @IBOutlet var instructionHeightConstraint: NSLayoutConstraint!
    @IBOutlet var instructionViews: [UIView] = []
    
    @IBOutlet var tableContainerView: UIView!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
//        let user = AppDelegate.sharedAppDelegate.currentUser!
//        if !user.hasFamilies {
//            if !user.isAdult {
//                self.instructionHeightConstraint.constant = self.view.bounds.height / 2.0
//            } else {
//                
//            }
//        } else {
            self.instructionTopConstraint.constant = self.view.bounds.height
            self.tableContainerView.hidden = false
//        }
    }
}

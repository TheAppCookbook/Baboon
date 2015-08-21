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
    @IBOutlet var addFamilyButton: UIButton!
    
    var instructionsShowing: Bool = true
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return self.instructionsShowing ? .LightContent : .Default
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        let user = User.currentUser()!
        if !user.hasFamily {
            if !user.isAdult {
                self.instructionHeightConstraint.constant = self.view.bounds.height / 2.0
            } else {
                
            }
        } else {
            self.instructionsShowing = false
            
            self.instructionTopConstraint.constant = self.view.bounds.height
            self.tableContainerView.hidden = false
        }
    }
    
    // MARK: Responders
    @IBAction func addFamilyButtonWasPressed(sender: UIButton!) {
        let user = User.currentUser()!
        if !user.hasFamily {
            self.instructionTopConstraint.constant = -self.view.bounds.height
            self.instructionsShowing = false
            
            self.tableContainerView.alpha = 0.0
            self.tableContainerView.hidden = false
            
            UIView.animateWithDuration(0.50) {
                for view in self.instructionViews {
                    view.layoutIfNeeded()
                    view.alpha = 0.0
                }
                
                self.tableContainerView.alpha = 1.0
                
                self.setNeedsStatusBarAppearanceUpdate()
                self.addFamilyButton.setTitle("Add Family Members",
                    forState: .Normal)
            }
        } else {
            
        }
    }
    
    @IBAction func dismissButtonWasPressed(sender: UIBarButtonItem!) {
        self.presentingViewController?.dismissViewControllerAnimated(true,
            completion: nil)
    }
}

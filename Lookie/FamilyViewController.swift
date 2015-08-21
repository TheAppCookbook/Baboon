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
    
    @IBOutlet var topInstructionLabel: UILabel!
    @IBOutlet var bottomInstructionLabel: UILabel!
    
    @IBOutlet var tableContainerView: UIView!
    var embededUserSearchField: (() -> UITextField)!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var addFamilyButton: UIButton!
    
    var instructionsShowing: Bool = true
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return self.instructionsShowing ? .LightContent : .Default
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        let user = User.currentUser()!
        if user.family == nil {
            if !user.isAdult {
                self.topInstructionLabel.text = "👨‍👩‍👧‍👦 📧 👩‍👩‍👦‍👦 📞 🎉 🎊 👻"
                self.topInstructionLabel.font = UIFont.systemFontOfSize(50.0)
                
                self.bottomInstructionLabel.text = "A parent or guardian needs to invite you to a Family!"
                
                self.addFamilyButton.setTitle("Ok!", forState: .Normal)
            }
        } else {
            self.instructionsShowing = false
            
            self.instructionTopConstraint.constant = self.view.bounds.height
            self.tableContainerView.hidden = false
            
            if !user.isAdult {
                self.addFamilyButton.hidden = true
                self.embededUserSearchField().hidden = true
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier {
        case .Some("EmbedFamily"):
            let membersVC = segue.destinationViewController as! FamilyMembersViewController
            self.embededUserSearchField = { membersVC.userSearchField }
            
        default:
            break
        }
    }
    
    // MARK: Responders
    @IBAction func addFamilyButtonWasPressed(sender: UIButton!) {
        let user = User.currentUser()!
        if !user.isAdult {
            self.presentingViewController?.dismissViewControllerAnimated(true,
                completion: nil)
            return
        }
        
        if user.family == nil && self.instructionsShowing {
            self.instructionTopConstraint.constant = -self.view.bounds.height
            self.instructionsShowing = false
            
            self.tableContainerView.alpha = 0.0
            self.tableContainerView.hidden = false
            
            user.family = NSUUID().UUIDString
            user.saveInBackgroundWithBlock(nil)
            
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
            let userIdentifier = self.embededUserSearchField().text
            let familyIdentifier = User.currentUser()!.family!
            
            self.embededUserSearchField().userInteractionEnabled = false
            
            self.addFamilyButton.hidden = true
            self.activityIndicator.startAnimating()
            
            User.userWithIdentifier(userIdentifier) { (user: User?) in
                if let user = user {
                    self.embededUserSearchField().text = ""
                    self.embededUserSearchField().placeholder = "Invitation was sent!"
                    
                    self.inviteUser(user, toFamily: familyIdentifier)
                } else {
                    self.embededUserSearchField().text = ""
                    self.embededUserSearchField().placeholder = "Who? 😛"
                }
                
                self.embededUserSearchField().userInteractionEnabled = true
                self.activityIndicator.stopAnimating()
                self.addFamilyButton.hidden = false
            }
        }
    }
    
    @IBAction func dismissButtonWasPressed(sender: UIBarButtonItem!) {
        self.presentingViewController?.dismissViewControllerAnimated(true,
            completion: nil)
    }
    
    // MARK: Invitation Handlers
    func inviteUser(user: User, toFamily family: String) {
        let currentUser = User.currentUser()!
        let invitation = Invitation(invitingUserName: currentUser.name,
            invitedUserID: user.username!,
            family: family)
        
        invitation.saveInBackgroundWithBlock(nil)
    }
}

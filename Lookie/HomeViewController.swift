//
//  HomeViewController.swift
//  Lookie!
//
//  Created by PATRICK PERINI on 8/20/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import UIKit
import ACBInfoPanel

class HomeViewController: UIViewController {
    // MARK: Properties
    @IBOutlet var familyButton: UIButton!
    @IBOutlet var postButton: UIButton!
    @IBOutlet var settingsButton: UIButton!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if User.currentUser() == nil {
            self.performSegueWithIdentifier("PresentLogin",
                sender: nil)
            return
        }
        
        let user = User.currentUser()!
        if user.isAdult && user.family == nil {
            self.performSegueWithIdentifier("PresentFamily",
                sender: nil)
            return
        }
        
        if user.isAdult {
            // Disable post button
            self.postButton.setImage(nil, forState: .Normal)
            self.postButton.setTitle("🔞", forState: .Normal)
            self.postButton.titleLabel?.font = UIFont.systemFontOfSize(40.0)
            self.postButton.enabled = false
            self.postButton.alpha = 0.5
        }
        
        user.invitations { (invitations: [Invitation]) in
            if let invitation = invitations.first {
                let alert = UIAlertController(title: "Join \(invitation.invitingUserName)'s family?",
                    message: "They've invited you to join their family!",
                    preferredStyle: .Alert)
                
                alert.addAction(UIAlertAction(title: "No", style: .Cancel) { (action: UIAlertAction!) in
                    invitations.map { $0.deleteInBackgroundWithBlock(nil) }
                })
                
                alert.addAction(UIAlertAction(title: "Join", style: .Default) { (action: UIAlertAction!) in
                    user.family = invitation.family
                    user.saveInBackgroundWithBlock(nil)
                    invitations.map { $0.deleteInBackgroundWithBlock(nil) }
                })
                
                self.presentViewController(alert,
                    animated: true,
                    completion: nil)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier {
        case .Some("PresentPost"):
            let postVC = segue.destinationViewController as! PostViewController
            postVC.image = (sender as! UIImage)
        
        default:
            break
        }
    }
    
    // MARK: Responders
    @IBAction func postButtonWasPressed(sender: UIButton!) {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
        } else {
            imagePicker.sourceType = .PhotoLibrary
        }
        
        imagePicker.delegate = self
        self.presentViewController(imagePicker,
            animated: true,
            completion: nil)
    }
    
    @IBAction func settingsButtonWasPressed(sender: UIButton!) {
        let infoPanel = ACBInfoPanelViewController()
        infoPanel.ingredient = "Self-Publishing for Kids"
        
        self.presentViewController(infoPanel,
            animated: true,
            completion: nil)
    }
}

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        picker.dismissViewControllerAnimated(true,
            completion: nil)
        
        self.performSegueWithIdentifier("PresentPost",
            sender: image)
    }
}


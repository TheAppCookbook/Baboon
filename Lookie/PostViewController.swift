//
//  PostViewController.swift
//  Lookie!
//
//  Created by PATRICK PERINI on 8/20/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    // MARK: Properties
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleField: UITextField!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var postButton: UIButton!
    
    var image: UIImage?
    
    var validInput: Bool {
        return (self.titleField.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0)
    }
    
    // MARK: Lifecylce
    override func viewDidLoad() {
        self.imageView.image = self.image
    }
    
    // MARK: Responders
    @IBAction func cancelButtonWasPressed(sender: UIBarButtonItem!) {
        self.presentingViewController?.dismissViewControllerAnimated(true,
            completion: nil)
    }
    
    @IBAction func postButtonWasPressed(sender: UIButton!) {
        self.postButton.hidden = true
        self.activityIndicator.startAnimating()
        
        self.titleField.resignFirstResponder()
        self.view.userInteractionEnabled = false
        
        let user = User.currentUser()!
        let post = Post(title: self.titleField.text,
            author: user)
        
        post.setImage(self.image!) { (url: NSURL?) in
            post.saveInBackgroundWithBlock { (success: Bool, error: NSError?) in
                self.presentingViewController?.dismissViewControllerAnimated(true,
                    completion: nil)
            }
        }
    }
    
    private func inputChanged() {
        self.postButton.enabled = self.validInput
        self.postButton.alpha = self.postButton.enabled ? 1.0 : 0.5
    }
}

extension PostViewController: UITextFieldDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        self.inputChanged()
        return true
    }
}
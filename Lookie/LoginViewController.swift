//
//  LoginViewController.swift
//  Lookie!
//
//  Created by PATRICK PERINI on 8/20/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    // MARK: Properties
    @IBOutlet var label: UILabel!
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var emojiField: UITextField!
    @IBOutlet var identifierField: UITextField!
    @IBOutlet var birthYearField: UITextField!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var signupButton: UIButton!
    
    var birthYear: Int? {
        return (self.birthYearField.text as NSString?)?.integerValue
    }
    
    var inputValid: Bool {
        return (self.nameField.text!.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0) &&
            (self.emojiField.text!.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0) &&
            (User.identifierIsValid(self.identifierField.text!)) &&
            (self.birthYear > 1800)
    }
    
    // MARK: Responders
    private func inputChanged() {
        self.signupButton.enabled = self.inputValid
        self.signupButton.alpha = self.signupButton.enabled ? 1.0 : 0.5
    }
    
    @IBAction func signupButtonWasPressed(sender: UIButton!) {
        let user = User(name: self.nameField.text!,
            emoji: self.emojiField.text!,
            birthYear: self.birthYear!,
            identifier: self.identifierField.text!)
        
        self.signupButton.hidden = true
        self.activityIndicator.startAnimating()
        
        self.nameField.resignFirstResponder()
        self.emojiField.resignFirstResponder()
        self.identifierField.resignFirstResponder()
        self.birthYearField.resignFirstResponder()
        self.view.userInteractionEnabled = false
        
        user.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) in
            if success && error == nil {
                self.presentingViewController?.dismissViewControllerAnimated(true,
                    completion: nil)
            } else {
                self.activityIndicator.stopAnimating()
                self.view.userInteractionEnabled = true
                self.signupButton.hidden = false
                
                self.label.text = "Oh no, something went wrong! 🙀"
            }
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == self.emojiField {
            return (string.containsEmoji && textField.text?.characters.count == 0) || string.isEmpty
        }
        
        self.inputChanged()
        return true
    }
}

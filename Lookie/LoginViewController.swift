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
    @IBOutlet var nameField: UITextField!
    @IBOutlet var emojiField: UITextField!
    @IBOutlet var identifierField: UITextField!
    @IBOutlet var birthYearField: UITextField!
}

extension LoginViewController: UITextFieldDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == self.emojiField {
            return string.containsEmoji || string.isEmpty
        }
        
        return true
    }
}

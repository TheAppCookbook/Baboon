//
//  FeedViewController.swift
//  Lookie!
//
//  Created by PATRICK PERINI on 8/20/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    // MARK: Properties
    @IBOutlet var familyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.familyButton.setTitle(String.familyEmojis.random(),
            forState: .Normal)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if AppDelegate.sharedAppDelegate.currentUser == nil {
            self.performSegueWithIdentifier("PresentLogin",
                sender: nil)
        }
    }
}


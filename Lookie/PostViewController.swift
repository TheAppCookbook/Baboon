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
    
    var image: UIImage?
    
    // MARK: Lifecylce
    override func viewDidLoad() {
        self.imageView.image = self.image
    }
    
    // MARK: Responders
    @IBAction func cancelButtonWasPressed(sender: UIBarButtonItem!) {
        self.presentingViewController?.dismissViewControllerAnimated(true,
            completion: nil)
    }
}

//
//  HomeViewController.swift
//  Lookie!
//
//  Created by PATRICK PERINI on 8/20/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: Properties
    @IBOutlet var familyButton: UIButton!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.familyButton.setTitle(String.familyEmojis.random(),
            forState: .Normal)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if User.currentUser() == nil {
            self.performSegueWithIdentifier("PresentLogin",
                sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier {
        case .Some("PresentPost"):
            let postVC = segue.destinationViewController as! PostViewController
            postVC.image = sender as! UIImage
        
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


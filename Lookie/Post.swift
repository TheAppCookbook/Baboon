//
//  Post.swift
//  Lookie!
//
//  Created by PATRICK PERINI on 8/20/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import Parse
import AFNetworking

class Post: PFObject, PFSubclassing {
    // MARK: ParseProperties
    @NSManaged var pTitle: String
    @NSManaged var pImageURL: String
    @NSManaged var pAuthor: String
    @NSManaged var pFamily: String
    
    class func parseClassName() -> String {
        return "Post"
    }
    
    // MARK: Properties
    var title: String { return self.pTitle }
    var imageURL: NSURL { return NSURL(string: self.pImageURL)! }
    
    // MARK: Initializers
    override init() {
        super.init()
    }
    
    init(title: String, author: User) {
        super.init()
        
        self.pTitle = title
        self.pAuthor = author.identifier
        self.pFamily = author.pFamily
    }
    
    // MARK: Accessors
    func author(completion: (User) -> Void) {
        let predicate = NSPredicate(format: "username = %@", self.pAuthor)
        User.queryWithPredicate(predicate)?.findObjectsInBackgroundWithBlock({ (objects: [AnyObject]?, error: NSError?) in
            let user = objects!.first as! User
            completion(user)
        })
    }
    
    // MARK: Mutators
    func setImage(image: UIImage, completion: (NSURL?) -> Void) {
        if let imageData = UIImagePNGRepresentation(image) {
            let encodedData = imageData.base64EncodedStringWithOptions(nil)
            
            let manager = AFHTTPRequestOperationManager()
            manager.responseSerializer = AFJSONResponseSerializer()
            manager.requestSerializer.setValue("Client-ID 5c4f0c2de0df9d3", forHTTPHeaderField: "Authorization")
            
            manager.POST("https://api.imgur.com/3/image", parameters: ["image": encodedData], success: { (op: AFHTTPRequestOperation!, response: AnyObject!) in
                self.pImageURL = (response["data"] as! NSDictionary)["link"] as! String
                completion(self.imageURL)
            }, failure: { (op: AFHTTPRequestOperation!, error: NSError!) in
                completion(nil)
            })
        }
    }
}

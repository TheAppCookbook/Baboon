//
//  Like.swift
//  Lookie!
//
//  Created by PATRICK PERINI on 8/20/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import Parse

class Like: PFObject, PFSubclassing {
    // MARK: ParseProperties
    @NSManaged var pPost: String
    @NSManaged var pUser: String
    
    var user: String { return self.pUser }
    
    class func parseClassName() -> String {
        return "Like"
    }
    
    // MARK: Initializers
    override init() {
        super.init()
    }
    
    init(post: Post, user: User) {
        super.init()
        
        self.pPost = post.pID
        self.pUser = user.username!
    }
}

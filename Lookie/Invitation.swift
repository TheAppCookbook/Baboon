//
//  Invitation.swift
//  Lookie!
//
//  Created by PATRICK PERINI on 8/20/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import Parse

class Invitation: PFObject, PFSubclassing {
    // MARK: ParseProperties
    @NSManaged var pInvitingUserName: String
    @NSManaged var pInvitedUser: String
    @NSManaged var pFamily: String
    
    var invitingUserName: String { return self.pInvitingUserName }
    var family: String { return self.pFamily }
    
    class func parseClassName() -> String {
        return "Invitation"
    }
    
    // MARK: Initializers
    override init() {
        super.init()
    }
    
    init(invitingUserName: String, invitedUserID: String, family: String) {
        super.init()
        
        self.pInvitingUserName = invitingUserName
        self.pInvitedUser = invitedUserID
        self.pFamily = family
    }
}

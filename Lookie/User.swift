//
//  User.swift
//  Lookie!
//
//  Created by PATRICK PERINI on 8/20/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import Parse

class User: PFUser, PFSubclassing {
    // MARK: Constants
    static let EmailRegex = NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,6}$",
        options: nil,
        error: nil)!
    static let PhoneRegex = NSRegularExpression(pattern: "^(\\+\\d{1,2}\\s)?\\(?\\d{3}\\)?[\\s.-]?\\d{3}[\\s.-]?\\d{4}$",
        options: nil,
        error: nil)!
    static let AdulthoodAge = 16
    
    // MARK: Parse Properties
    @NSManaged var pName: String
    @NSManaged var pEmoji: String
    @NSManaged var pBirthYear: Int
    @NSManaged var pFamily: String
    
    // MARK: Properties
    var name: String { return self.pName }
    var birthYear: Int { return self.pBirthYear }
    var identifier: String { return self.username! }
    var emoji: String { return self.pEmoji }
    
    var isAdult: Bool {
        let year = NSCalendar.currentCalendar().component(NSCalendarUnit.CalendarUnitYear,
            fromDate: NSDate())
        
        return (year - User.AdulthoodAge) > self.birthYear
    }
    
    var hasFamily: Bool {
        return self.pFamily.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0
    }
    
    // MARK: Initializers
    override init() {
        super.init()
    }
    
    init(name: String, emoji: String, birthYear: Int, identifier: String) {
        super.init()
        
        self.pName = name
        self.pEmoji = emoji
        self.pBirthYear = birthYear
        self.pFamily = ""
        
        self.username = identifier
        self.password = NSUUID().UUIDString
    }
    
    // MARK: Accessors
    func setFamily(identifier: String) {
        self.pFamily = identifier
    }
    
    func posts(completion: ([Post]) -> Void) {
        let predicate = NSPredicate(format: "pAuthor = %@", self.identifier)
        Post.queryWithPredicate(predicate)?.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) in
            let posts = objects as! [Post]
            completion(posts)
        }
    }
    
    func feed(completion: ([Post]) -> Void) {
        let predicate = NSPredicate(format: "(pAuthor = %@) OR (pFamily = %@)", self.identifier, self.pFamily)
        Post.queryWithPredicate(predicate)?.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) in
            let posts = (objects as! [Post]).reverse()
            completion(posts)
        }
    }

    // MARK: Class Accessors
    class func identifierIsValid(identifier: String) -> Bool {
        let length = identifier.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        
        let validEmail = EmailRegex.firstMatchInString(identifier,
            options: nil,
            range: NSMakeRange(0, length)) != nil
        let validPhone = PhoneRegex.firstMatchInString(identifier,
            options: nil,
            range: NSMakeRange(0, length)) != nil
        
        return validEmail || validPhone
    }
}

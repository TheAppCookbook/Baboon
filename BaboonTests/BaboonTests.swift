//
//  BaboonTests.swift
//  BaboonTests
//
//  Created by PATRICK PERINI on 8/20/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import UIKit
import XCTest
import Parse

class BaboonTests: XCTestCase {
    
    func testAdulthood() {
        let user = User(name: "Test User",
            birthYear: 1991,
            identifier: "+1 240 291 2158")
        XCTAssertTrue(user.isAdult, "User is not adult")
    }
    
    func testRegistration() {
        let user = User(name: "Test User",
            birthYear: 1991,
            identifier: "+1 240 291 2158")
        
        let success: Bool = user.signUp()
        
        XCTAssertTrue(success, "User was not registered")
        XCTAssertEqual(PFUser.currentUser()!.username!, user.username!, "User is not current user")
        
        user.delete()
        PFUser.logOut()
    }
    
    func testLogin() {
        let user = User(name: "Test User",
            birthYear: 1991,
            identifier: "+1 240 291 2158")
        
        let signUpSuccess: Bool = user.signUp()
        
        XCTAssertTrue(signUpSuccess, "User was not registered")
        XCTAssertEqual(PFUser.currentUser()!, user, "User is not current user")
        
        PFUser.logOut()
        PFUser.logInWithUsername(user.username!,
            password: user.password!)
        
        XCTAssertEqual(PFUser.currentUser()!.username!, user.username!, "User is not current user")

        PFUser.currentUser()?.delete()
        PFUser.logOut()
    }
}

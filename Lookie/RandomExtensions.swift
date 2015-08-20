//
//  RandomExtensions.swift
//  Lookie!
//
//  Created by PATRICK PERINI on 8/20/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import Foundation

extension Array {
    func random() -> T? {
        if self.count == 0 { return nil }
        return self[Int(arc4random_uniform(UInt32(self.count)))]
    }
}
//
//  EmojiExtensions.swift
//  Lookie!
//
//  Created by PATRICK PERINI on 8/20/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import Foundation

extension String {
    // MARK: Constants
    // TODO: Add colors
    static let familyEmojis: [String] = [
        "👪", "👨‍👩‍👧", "👨‍👩‍👧‍👦", "👨‍👩‍👦‍👦", "👨‍👩‍👧‍👧", "👩‍👩‍👦", "👩‍👩‍👧",
        "👩‍👩‍👧‍👦", "👩‍👩‍👦‍👦", "👩‍👩‍👧‍👧", "👨‍👨‍👦", "👨‍👨‍👧", "👨‍👨‍👧‍👦", "👨‍👨‍👦‍👦", "👨‍👨‍👧‍👧"
    ]
    
    var containsEmoji: Bool {
        var containsEmoji = false
        
        for scalar in self.unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F:
                // Emoticons
                containsEmoji = true
            case 0x1F300...0x1F5FF:
                // Misc Symbols and Pictographs
                containsEmoji = true
            case 0x1F680...0x1F6FF:
                // Transport and Map
                containsEmoji = true
            case 0x2600...0x26FF:
                // Misc symbols, not all emoji
                containsEmoji = true
            case 0x2700...0x27BF:
                // Dingbats, not all emoji
                containsEmoji = true
            default:
                break
            }
        }
        
        return containsEmoji
    }
}
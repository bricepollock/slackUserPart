//
//  SlackUserPartyTests.swift
//  SlackUserPartyTests
//
//  Created by Brice Pollock on 2/19/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import XCTest
import UIKit
@testable import SlackUserParty

class UsersViewProcessorTests: XCTestCase {
    let processor = UsersViewProcessor()
    
    // MARK: textColor
    func testTextColor_isDeleted() {
        let result = processor.textColor(deleted: true)
        let expected = UIColor.gray
        XCTAssertEqual(result, expected)
    }
    
    func testTextColor_isNotDeleted() {
        let result = processor.textColor(deleted: false)
        let expected = UIColor.black
        XCTAssertEqual(result, expected)
    }
    
    // MARK: namString
    
    func testNameString_onlyName() {
        let name = "username"
        let realName: String? = nil
        let isDeleted = false
        let isBot = false
        let result = processor.nameString(given: name, realName: realName, isDeleted: isDeleted, isBot: isBot)
        let expected = name
        XCTAssertEqual(result, expected)
    }
    
    func testNameString_onlyName_isBot() {
        let name = "username"
        let realName: String? = nil
        let isDeleted = false
        let isBot = true
        let result = processor.nameString(given: name, realName: realName, isDeleted: isDeleted, isBot: isBot)
        let expected = name + "🤖"
        XCTAssertEqual(result, expected)
    }
    
    func testNameString_onlyName_isDeleted() {
        let name = "username"
        let realName: String? = nil
        let isDeleted = true
        let isBot = false
        let result = processor.nameString(given: name, realName: realName, isDeleted: isDeleted, isBot: isBot)
        let expected = name + "☠️"
        XCTAssertEqual(result, expected)
    }
    
    func testNameString_onlyName_isDeletedBot() {
        let name = "username"
        let realName: String? = nil
        let isDeleted = true
        let isBot = true
        let result = processor.nameString(given: name, realName: realName, isDeleted: isDeleted, isBot: isBot)
        let expected = name + "☠️" + "🤖"
        XCTAssertEqual(result, expected)
    }
    
    func testNameString_realName() {
        let name = "username"
        let realName = "Gwenith Swiftwala"
        let isDeleted = false
        let isBot = false
        let result = processor.nameString(given: name, realName: realName, isDeleted: isDeleted, isBot: isBot)
        let expected = realName
        XCTAssertEqual(result, expected)
    }
    
    func testNameString_all() {
        let name = "username"
        let realName = "Gwenith Swiftwala"
        let isDeleted = true
        let isBot = true
        let result = processor.nameString(given: name, realName: realName, isDeleted: isDeleted, isBot: isBot)
        let expected = realName + "☠️" + "🤖"
        XCTAssertEqual(result, expected)
    }
}

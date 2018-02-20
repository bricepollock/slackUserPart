//
//  CollectionSafeTests.swift
//  SlackUserPartyTests
//
//  Created by Brice Pollock on 2/19/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import XCTest
@testable import SlackUserParty

class CollectionSafeTests: XCTestCase {
    
    func testSafeIndex_empty_negative() {
        let array = [Int]()
        XCTAssertNil(array[safe: -10])
    }
    
    func testSafeIndex_empty_upperBounds() {
        let array = [Int]()
        XCTAssertNil(array[safe: 10])
    }
    
    func testSafeIndex_empty_zero() {
        let array = [Int]()
        XCTAssertNil(array[safe: 0])
    }
    
    func testSafeIndex_upperBounds() {
        let array = [1, 3, 8]
        XCTAssertNil(array[safe: 100])
    }
    
    func testSafeIndex_negative() {
        let array = [1, 3, 8]
        XCTAssertNil(array[safe: -10])
    }
    
    func testSafeIndex_found() {
        let array = [1, 3, 8]
        XCTAssertEqual(array[safe: 2], array[2])
    }
}

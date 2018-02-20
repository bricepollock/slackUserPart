//
//  DataStoreTests.swift
//  SlackUserPartyTests
//
//  Created by Brice Pollock on 2/19/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation
import XCTest
import UIKit
@testable import SlackUserParty

struct StoreObject: Codable {
    let num: Int
    let string: String
    let child: ChildObject
}

struct ChildObject: Codable {
    let num: Int
    let string: String
}

class DataStoreTests: XCTestCase {
    let dataStore = DataStore()

    override func tearDown() {
        dataStore.purgeAll()
    }
    
    func testDataStore_readWrite() {
        let child = ChildObject(num: 15, string: "child")
        let object = StoreObject(num: 10, string: "parent", child: child)
        
        let key = "someKey"
        let noObject: StoreObject? = dataStore.read(for: key)
        XCTAssertNil(noObject)
        
        dataStore.write(value: object, for: key)
        
        guard let storedObject: StoreObject? = dataStore.read(for: key) else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(storedObject?.num, 10)
        XCTAssertEqual(storedObject?.string, "parent")
        XCTAssertEqual(storedObject?.child.num, 15)
        XCTAssertEqual(storedObject?.child.string, "child")
    }
    
    func testDataStore_overwrite() {
        let child = ChildObject(num: 15, string: "child")
        let object = StoreObject(num: 10, string: "parent", child: child)
        
        // check we start with an empty cache
        let key = "someKey"
        let noObject: StoreObject? = dataStore.read(for: key)
        XCTAssertNil(noObject)
        
        // write object
        dataStore.write(value: object, for: key)
        
        // Make sure first written is as expected
        guard let storedObject: StoreObject? = dataStore.read(for: key) else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(storedObject?.num, 10)
        
        // over write object
        let overwrite = StoreObject(num: 25, string: "parent_override", child: child)
        dataStore.write(value: overwrite, for: key)
        
        guard let overWrittenObject: StoreObject? = dataStore.read(for: key) else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(overWrittenObject?.num, 25)
    }
}

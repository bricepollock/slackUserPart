//
//  ImageCacheTests.swift
//  SlackUserPartyTests
//
//  Created by Brice Pollock on 2/19/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import XCTest
@testable import SlackUserParty

class ImageCacheTests: XCTestCase {
    
    func testCache() {
        let urlKey = "https://avatars.slack-edge.com/2015-05-01/4698799712_e1784211d2146055eb02_192.jpg"
        XCTAssertNil(ImageCache.shared.cachedImage(for: urlKey))
        
        guard let image = UIImage(named: "ic_profile_header") else { XCTFail(); return }
        ImageCache.shared.cache(image: image, for: urlKey)
        
        XCTAssertNotNil(ImageCache.shared.cachedImage(for: urlKey))
    }
}

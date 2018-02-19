//
//  UIImage+url.swift
//  SlackUserParty
//
//  Created by Brice Pollock on 2/15/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    convenience init?(url urlString: String) {
        // TODO: Add caching
        guard let url = URL(string: urlString) else {
            logDebug("Unable to get create image url from: \(urlString)")
            return nil
        }
        guard let data = try? Data(contentsOf: url) else {
            logDebug("Unable to create data from image url: \(urlString)")
            return nil
        }        
        self.init(data: data)
    }
}

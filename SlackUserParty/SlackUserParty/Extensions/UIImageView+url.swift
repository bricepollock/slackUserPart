//
//  UIImageView+url.swift
//  SlackUserParty
//
//  Created by Brice Pollock on 2/19/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    /// Request and then update UIImage view asynchrnously without blocking main thread
    func asyncImage(with urlString: String) {
        backgroundColor = UIColor.gray
        ImageCache.shared.image(for: urlString) { [weak self] (image) in
            self?.image = image
            self?.setNeedsDisplay()
        }
    }
}

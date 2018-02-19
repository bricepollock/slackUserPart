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
    func asyncImage(with urlString: String) {
        backgroundColor = UIColor.gray
        DispatchQueue.global().async { [weak self] in
            guard let image = UIImage(url: urlString) else { return }
            DispatchQueue.main.async {
                self?.image = image
                self?.setNeedsDisplay()
            }
        }
    }
}

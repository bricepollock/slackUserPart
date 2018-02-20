//
//  UIColor+components.swift
//  SlackUserParty
//
//  Created by Brice Pollock on 2/19/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {
    var r: CGFloat{ return CIColor(color: self).red }
    var g: CGFloat{ return CIColor(color: self).green }
    var b: CGFloat{ return CIColor(color: self).blue }
    var a: CGFloat{ return CIColor(color: self).alpha }
}

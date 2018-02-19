//
//  UserProfileViewController.swift
//  SlackUserParty
//
//  Created by Brice Pollock on 2/15/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation
import UIKit

class UserProfileViewController: UIViewController {
    // I allow a forced unwrapping here because using our creation function ensures this data will always exist
    // This pattern allows us to pass data forward without refetching and eliminates the challenges of constantly
    // unwrapping data that should always exist.
    var user: User!
    
    static func create(for user: User) -> UserProfileViewController {
        let viewController: UserProfileViewController = createInstanceFromStoryboard()
        viewController.user = user
        return viewController
    }
}

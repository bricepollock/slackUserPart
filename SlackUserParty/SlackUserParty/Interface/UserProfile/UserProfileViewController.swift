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
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileDetailsStackView: UIStackView!
    
    // I allow a forced unwrapping here because using our creation function ensures this data will always exist
    // This pattern allows us to pass data forward without refetching and eliminates the challenges of constantly
    // unwrapping data that should always exist.
    var user: User!
    
    // Keep strings at the top to help with migration to our future localization strategy for such strings
    let nameString = "Name:"
    let jobTitleString = "Position:"
    
    static func create(for user: User) -> UserProfileViewController {
        let viewController: UserProfileViewController = createInstanceFromStoryboard()
        viewController.user = user
        return viewController
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderWidth = 3.0
        profileImageView.layer.borderColor = UIColor.white.cgColor

    }
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        headerImageView.image = UIImage(named: "ic_profile_header")
        profileImageView.asyncImage(with: user.profile.image192)
        
        usernameLabel.text = "@\(user.name)"
        usernameLabel.textColor = UIColor.blue
        usernameLabel.font = UIFont.systemFont(ofSize: 12)
        
        addUserInfoIfNeeded(for: user.profile.realName, with: nameString)
        addUserInfoIfNeeded(for: user.profile.title, with: jobTitleString)
    }
    
    func addUserInfoIfNeeded(for value: String?, with title: String) {
        guard let value = value, !value.isEmpty else { return }
        let detailedView: UserProfileDetailView = UserProfileDetailView.createInstanceFromNib()
        profileDetailsStackView.addArrangedSubview(detailedView)
        detailedView.configure(with: UserProfileDetailViewData(title: title, detail: value))
    }
    
}

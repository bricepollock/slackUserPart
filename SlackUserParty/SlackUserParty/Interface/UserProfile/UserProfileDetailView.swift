//
//  UserProfileDetail.swift
//  SlackUserParty
//
//  Created by Brice Pollock on 2/19/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation
import UIKit

// The creation of a Title: Detail view allows a leveragable component with consistent branding to use through the rest of the app.
// Additionally it makes it so we can quickly expand the number of detailed items we want displayed on the profile in the future
// without adding more and more constraints to the main view controller view
struct UserProfileDetailViewData {
    let title: String
    let detail: String
}

class UserProfileDetailView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    func configure(with data: UserProfileDetailViewData) {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.text = data.title
        
        detailLabel.font = UIFont.systemFont(ofSize: 18)
        detailLabel.text = data.detail
    }
}

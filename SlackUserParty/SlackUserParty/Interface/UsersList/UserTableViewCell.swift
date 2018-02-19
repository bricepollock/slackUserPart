//
//  UserTableViewCell.swift
//  SlackUserParty
//
//  Created by Brice Pollock on 2/15/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation
import UIKit

struct UserTableViewCellData {
    let userName: String
    let userNameTextColor: UIColor
    let userImageURL: String
}

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    static let name = String(describing: UserTableViewCell.self)
    static func register(in tableView: UITableView) {
        let nib = UINib(nibName: name, bundle: Bundle(for: self))
        tableView.register(nib, forCellReuseIdentifier: name)
    }
    
    func configure(with data: UserTableViewCellData) {
        userImage.asyncImage(with: data.userImageURL)
        userName.text = data.userName
        userName.textColor = data.userNameTextColor
    }
}

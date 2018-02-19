//
//  UsersViewProcessor.swift
//  SlackUserParty
//
//  Created by Brice Pollock on 2/15/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation
import UIKit

struct UsersViewProcessor {
    func createUsersData(from userResponse: UserListResponse) -> [UserTableViewCellData] {
        return userResponse.members.flatMap { (user) -> UserTableViewCellData? in
            return UserTableViewCellData(
                userName: nameString(given: user.name, realName: user.profile.realName, isDeleted: user.isDeleted, isBot: user.isBot),
                userNameTextColor: textColor(deleted: user.isDeleted),
                userImageURL: user.profile.image48
            )
        }
    }
    
    func nameString(given name: String, realName: String?, isDeleted: Bool, isBot: Bool) -> String {
        var profileName = realName ?? name
        if isDeleted {
            profileName.append("☠️")
        }
        if isBot {
            profileName.append("🤖")
        }
        return profileName
    }
    
    func textColor(deleted isDeleted: Bool) -> UIColor {
        return isDeleted ? UIColor.gray : UIColor.black
    }
}

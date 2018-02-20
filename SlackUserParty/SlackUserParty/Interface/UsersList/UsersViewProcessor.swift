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
        var lastColor = UIColor.yellow
        var isAscentUpOriented = true
        return userResponse.members.flatMap { (user) -> UserTableViewCellData? in
            isAscentUpOriented = !isAscentUpOriented
            lastColor = ascentColor(given: lastColor)
            return UserTableViewCellData(
                userName: nameString(given: user.name, realName: user.profile.realName, isDeleted: user.isDeleted, isBot: user.isBot),
                userNameTextColor: textColor(deleted: user.isDeleted),
                userImageURL: user.profile.image48,
                ascentColor: lastColor,
                isAscentUpOriented: isAscentUpOriented
            )
        }
    }
    
    func ascentColor(given lastColor: UIColor) -> UIColor {
        let incrementValue: CGFloat = 30/255
        let alpha: CGFloat = 0.3
        return UIColor(red: lastColor.r - incrementValue,
                       green: lastColor.g,
                       blue: lastColor.b,
                       alpha: alpha)
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

//
//  SlackUserStructs.swift
//  SlackUserParty
//
//  Created by Brice Pollock on 2/15/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation

struct UserListResponse: Codable {
    let ok: Bool
    let error: SlackErrorType?
    let members: [User]
    let metadata: ResponseMetadata
    
    enum CodingKeys: String, CodingKey {
        case metadata = "response_metadata"
        case ok, error, members
    }
}

struct ResponseMetadata: Codable {
    let nextCursor: String
    
    enum CodingKeys: String, CodingKey {
        case nextCursor = "next_cursor"
    }
}

struct User: Codable {
    let id: String
    let name: String
    let profile: UserProfile
    let isAdmin: Bool
    let isDeleted: Bool
    let isBot: Bool
    
    enum CodingKeys: String, CodingKey {
        case isAdmin = "is_admin"
        case isDeleted = "deleted"
        case isBot = "is_bot"
        case id, name, profile
    }
}

struct UserProfile: Codable {
    let avatarHash: String
    let statusEmoji: String?
    let realName: String?
    let email: String?
    let image24: String
    let image48: String
    let image72: String
    let image192: String
    
    enum CodingKeys: String, CodingKey {
        case avatarHash = "avatar_hash"
        case statusEmoji = "status_emoji"
        case realName = "real_name"
        case email
        case image24 = "image_24"
        case image48 = "image_48"
        case image72 = "image_72"
        case image192 = "image_192"
    }
}

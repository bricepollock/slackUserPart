//
//  SlackUserService.swift
//  SlackUserParty
//
//  Created by Brice Pollock on 2/15/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation

struct SlackUserService {
    let slackHelper = SlackNetworkHelper()
    let manager = DataManager()
    
    func users(cursor: String? = nil, completion: @escaping (UserListResponse?) -> Void) {
        let limit = 20
        var queries = [
            URLQueryItem(name: "limit", value: String(limit))
        ]
        
        if let cursor = cursor {
            queries.append(URLQueryItem(name: "cursor", value: cursor))
        }
        
        guard let url = slackHelper.slackURL(for: .userList, with: queries) else { completion(nil); return}
        manager.data(for: url, completion: completion)
    }
}

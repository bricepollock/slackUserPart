//
//  SlackNetworkService.swift
//  SlackUserParty
//
//  Created by Brice Pollock on 2/15/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation

enum SlackRouteComponent: String {
    case userList = "users.list"
}

/// See documentation for errors at https://api.slack.com/methods/users.list
enum SlackErrorType: String, Codable {
    case invalidCursor = "invalid_cursor"
    case notAuth = "not_authed"
    case invalidAuth = "invalid_auth"
    case accountInactive = "account_inactive"
    case noPermission = "no_permission"
    case invalidArgName = "invalid_arg_name"
    case invalidArrayArg = "invalid_array_arg"
    case invalidCharset = "invalid_charset"
    case invalidFormData = "invalid_form_data"
    case invalidPostType = "invalid_post_type"
    case missingPostType = "missing_post_type"
    case teamAddedToOrg = "team_added_to_org"
    case requestTimeout = "request_timeout"
    case fatal_error = "fatal_error"
    
    // TODO: put in own enum and union two together
    case warningMissingCharset = "missing_charset"
    case warningSuperfluousCharset = "superfluous_charset"
}

struct SlackNetworkHelper {
    private let scheme = "https"
    private let host = "slack.com"
    private let APIPath = "/api"
    private let networkManager = NetworkManager()
    
    func slackURL(for route: SlackRouteComponent, with queries: [URLQueryItem])  -> URL? {
        let urlComponents = NSURLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = "\(APIPath)/\(route.rawValue)"
        urlComponents.queryItems = queries + [
            URLQueryItem(name: "token", value: slackSecretToken)
        ]
        return urlComponents.url
    }
}

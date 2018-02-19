//
//  Logger.swift
//  SlackUserParty
//
//  Created by Brice Pollock on 2/15/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation

func logDebug(_ logString: String) {
    #if DEBUG
        print(logString)
    #endif
}

func isAppInDebug() -> Bool {
    #if DEBUG
        return true
    #else
        return false
    #endif
}


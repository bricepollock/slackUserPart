//
//  DataManager.swift
//  SlackUserParty
//
//  Created by Brice Pollock on 2/19/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation

// This is our object we will use to make all caching decisions.
// This allows all our API services to focus on requesting data correctly
// This also allows networkManagers to focus on network and data store to focus on persistence
// In the future we will implement cache expiry, strategies, purging, etc.
class DataManager {
    private let slackHelper = SlackNetworkHelper()
    private let network = NetworkManager()
    private let persistence = DataStore()
    
    func data<T: Codable>(for url: URL, completion: @escaping (T?) -> Void) {
        // I've repeatedly found structured data stores (CoreData) to be combersume for most needs on mobile.
        // Comparatively key-value stores are fast, simpile, easy to maintain without the problems of resource contention
        // trying to update a stored object from multiple threads, upgrade or maintain complex relationships.
        //
        // When selecting a generic key structure off of a URL there are multiple tradeoffs about what to include
        // or not include such as query parameters, etc. By using the whole URL we avoid many of the potential issues.
        // Example: a prior cached limit=20 doesn't return if we change limit = 100
        let cacheKey = url.absoluteString
        
        if let cachedValue: T = persistence.read(for: cacheKey) {
            completion(cachedValue)
            return
        }
        
        network.makeURLRequest(for: url) { [weak self] (response: T?) in
            guard let response = response else { completion(nil); return }
            self?.persistence.write(value: response, for: cacheKey)
            completion(response)
        }
    }
}

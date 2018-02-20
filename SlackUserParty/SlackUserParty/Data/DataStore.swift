//
//  DataStore.swift
//  SlackUserParty
//
//  Created by Brice Pollock on 2/19/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation

struct DataStore {
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    // FIXME: Use one of the many key-value persistence frameworks instead of user defaults
    let store = UserDefaults.standard
    
    func write<T: Codable>(value: T, for key: String) {
        guard let encoded = try? encoder.encode(value) else {
            logDebug("Unable to encode object \(String(describing: value.self))")
            return
        }
        store.set(encoded, forKey: key)
    }
    
    func read<T: Codable>(for key: String) -> T? {
        guard let found = store.object(forKey: key) as? Data else { return nil }
        guard let object = try? decoder.decode(T.self, from: found) else {
            logDebug("Unable to decode object of type \(String(describing: T.self)) for key \(key)")
            return nil
        }
        return object
    }
    
    /// WARNING! Also purges image store
    /// FIXME: When we move to framework based persistence purging a shared cache will no longer be a problem.
    /// This method exists primarily for testing at this point since we don't expire our cache data
    internal func purgeAll() {
        guard let bundleID = Bundle.main.bundleIdentifier else { return }
        UserDefaults.standard.removePersistentDomain(forName: bundleID)
    }
}

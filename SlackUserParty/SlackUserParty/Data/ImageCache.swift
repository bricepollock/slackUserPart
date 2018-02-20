//
//  ImageCache.swift
//  SlackUserParty
//
//  Created by Brice Pollock on 2/19/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation
import UIKit

// I have a seperate ImageCache from DataStore because I want my image cache to be a blob cache indepentent
// from my network API cache structure so I can change them independently and implement seperate cache purging strategies for each.
class ImageCache {
    // I use a singleton here to avoid creating an image cache everywhere in our UIImageViews and placing distracting logic
    // around view code.
    static let shared = ImageCache()
    private let store = UserDefaults.standard
    private init() { }
    
    /// Retrieves image from URL and returns it in the completion block
    /// Always hits cache first without expiry for an image string
    /// Requests image in background and returns image on main thread
    func image(for urlString: String, with completion: @escaping (UIImage?) -> Void) {
        if let cached = cachedImage(for: urlString) {
            completion(cached)
            return
        }
        
        networkImage(for: urlString, with: completion)
    }
    
    internal func cachedImage(for urlString: String) -> UIImage? {
        // TODO: Use a simple Key Value store outside of extermely inspectable UserDefaults which isn't
        // created for this type of storage
        guard let data = store.data(forKey: urlString) else { return nil }
        return UIImage(data: data)
    }
    
    internal func cache(image: UIImage, for urlString: String) {
        store.set(UIImageJPEGRepresentation(image, 1.0), forKey: urlString)
    }

    private func networkImage(for urlString: String, with completion: @escaping (UIImage?) -> Void) {
        // we are not worried about race conditions writing to the same url, but if we wanted more safety we could
        // restrict adding to cache on a single serial thread we manage
        DispatchQueue.global().async { [weak self] in
            guard let image = UIImage(url: urlString) else { return }
            self?.cache(image: image, for: urlString)
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}


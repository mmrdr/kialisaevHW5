//
//  ImageCache.swift
//  kialisaevHW5
//
//  Created by Кирилл Исаев on 11.12.2024.
//

import UIKit
import Foundation

final class ImageCache {
    static let shared = ImageCache()
    
    private let cache = NSCache<NSURL, UIImage>()
    
    func getImage(for url: NSURL) -> UIImage? {
        return cache.object(forKey: url)
    }
    
    func saveImage(_ image: UIImage, for url: NSURL) {
        cache.setObject(image, forKey: url)
    }
}

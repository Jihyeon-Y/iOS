//
//  ImageStore.swift
//  ShoppingList
//
//  Created by 윤지현 on 2022/02/16.
//

import UIKit

class ImageStore {
    let cache = NSCache<NSString, UIImage>()
    func setImage(key: String, image: UIImage) {
        cache.setObject(image, forKey: key as NSString)
        let url = imageURL(key: key)
        if let data = image.jpegData(compressionQuality: 0.5) {
            try? data.write(to: url)
        }
    }
    func fetchImage(key: String) -> UIImage? {
        if let exist = cache.object(forKey: key as NSString) {
            return exist
        }
        let url = imageURL(key: key)
        guard let image = UIImage(contentsOfFile: url.path) else {
            return nil
        }
        cache.setObject(image, forKey: key as NSString)
        return image
    }
    func deleteImage(key: String) {
        cache.removeObject(forKey: key as NSString)
        let url = imageURL(key: key)
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            print("Error on deleting image: \(error)")
        }
    }
    func imageURL(key: String) -> URL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        print(documentDirectory)
        return documentDirectory.appendingPathComponent(key)
    }
}

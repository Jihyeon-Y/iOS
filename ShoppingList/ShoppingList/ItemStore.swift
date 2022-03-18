//
//  ItemStore.swift
//  ShoppingList
//
//  Created by 윤지현 on 2022/02/01.
//

import UIKit

class ItemStore {
    var allItems = [Item]()
    func removeItem(item: Item) {
        if let index = allItems.firstIndex(of: item) {
            allItems.remove(at: index)
        }
    }
    func moveItem(from: Int, to: Int) {
        if from == to {
            return
        }
        let movedItem = allItems[from]
        allItems.remove(at: from)
        allItems.insert(movedItem, at: to)
    }
    let itemStorageURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        print(documentDirectory)
        return documentDirectory.appendingPathComponent("items.plist")
    }()
    @objc func saveChanges() -> Bool {
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(allItems)
            try data.write(to: itemStorageURL, options: [.atomic])
            return true
        } catch {
            print("Encoding error: \(error)")
            return false
        }
    }
    init() {
        do {
            let data = try Data(contentsOf: itemStorageURL)
            let decoder = PropertyListDecoder()
            let items = try decoder.decode([Item].self, from: data)
            allItems = items
        } catch {
            print("Decoding error \(error)")
        }
        let notifiacation = NotificationCenter.default
        notifiacation.addObserver(self, selector: #selector(saveChanges), name: UIScene.didEnterBackgroundNotification, object: nil)
        notifiacation.addObserver(self, selector: #selector(saveChanges), name: UIScene.willDeactivateNotification, object: nil)
    }
}

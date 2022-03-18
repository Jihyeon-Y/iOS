//
//  Item.swift
//  ShoppingList
//
//  Created by 윤지현 on 2022/02/01.
//

import UIKit

class Item: Equatable, Codable {
    var name: String
    var rate: Int
    var valueInWon: Int
    var dateBought: Date
    var key: String
    init(name: String, rate: Int, value: Int, dateBought: Date) {
        self.name = name
        self.rate = rate
        self.valueInWon = value
        self.dateBought = Date()
        self.key = UUID().uuidString
    }
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name && lhs.rate == rhs.rate && lhs.valueInWon == rhs.valueInWon && lhs.dateBought == rhs.dateBought
    }
}

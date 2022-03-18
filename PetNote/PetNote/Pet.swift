//
//  Pet.swift
//  PetNote
//
//  Created by 윤지현 on 2022/02/19.
//

import UIKit

class Pet: Equatable {
    var image: UIImage?
    var name: String
    var birthday: Date
    var breed: String
    var gender: Int
    var weight: String
    init(image: UIImage?, name: String, birthday: Date, breed: String, gender: Int, weight: String) {
        self.image = image
        self.name = name
        self.birthday = Date()
        self.breed = breed
        self.gender = gender
        self.weight = weight
    }
    static func == (lhs: Pet, rhs: Pet) -> Bool {
        return lhs.name == rhs.name && lhs.breed == rhs.breed && lhs.gender == rhs.gender && lhs.weight == rhs.weight
    }
}

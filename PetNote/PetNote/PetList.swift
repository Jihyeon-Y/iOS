//
//  PetList.swift
//  PetNote
//
//  Created by 윤지현 on 2022/02/19.
//

import UIKit

class PetList {
    var pets = [Pet]()
    func removePet(item: Pet) {
        if let index = pets.firstIndex(of: item) {
            pets.remove(at: index)
        }
    }
    func movePet(from: Int, to: Int) {
        if from == to {
            return
        }
        let item = pets[from]
        pets.remove(at: from)
        pets.insert(item, at: to)
    }
}

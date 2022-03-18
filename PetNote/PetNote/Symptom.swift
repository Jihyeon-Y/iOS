//
//  Symptom.swift
//  PetNote
//
//  Created by 윤지현 on 2022/02/22.
//

import UIKit

struct Symptom {
    var name: String
    var color: UIColor
    var image: UIImage
}
extension Symptom {
    static let convulsed = Symptom(name: "convulsed", color: UIColor.convulsed, image: UIImage.convulsed)
    static let eat = Symptom(name: "didn't eat", color: UIColor.eat, image: UIImage.eat)
    static let insomnia = Symptom(name: "didn't sleep", color: UIColor.insomnia, image: UIImage.insomnia)
    static let grunted = Symptom(name: "grunted", color: UIColor.grunted, image: UIImage.grunted)
    static let diarrhea = Symptom(name: "had diarrhea", color: UIColor.diarrhea, image: UIImage.diarrhea)
    static let puked = Symptom(name: "puked", color: UIColor.puked, image: UIImage.puked)
    static let sleep = Symptom(name: "slept too much", color: UIColor.sleep, image: UIImage.sleep)
}

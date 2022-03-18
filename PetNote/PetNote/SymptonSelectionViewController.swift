//
//  SymptonSelectionViewController.swift
//  PetNote
//
//  Created by 윤지현 on 2022/02/22.
//

import UIKit

class SymptomSelectionViewController: UIViewController {
    var symptomLog: [SymptomLog] = []
    var symptoms: [Symptom] = [] {
        didSet {
            symptomButtons = symptoms.map { symptom in
                let symptomButton = UIButton()
                symptomButton.setImage(symptom.image, for: .normal)
                symptomButton.imageView?.contentMode = .scaleAspectFill
                symptomButton.addTarget(self, action: #selector(symptomChanged(_:)), for: .touchUpInside)
                return symptomButton
            }
        }
    }
    @IBOutlet var currentButton: UIButton!
    var currentSymptom: Symptom? {
        didSet {
            currentButton.layer.cornerRadius = currentButton.bounds.size.height / 2
            guard let currentSymptom = currentSymptom else {
                currentButton.setTitle(nil, for: .normal)
                currentButton.backgroundColor = .tintColor
                return
            }
            if pet.gender == 0 {
                currentButton.setTitle("He \(currentSymptom.name).", for: .normal)
            } else {
                currentButton.setTitle("She \(currentSymptom.name).", for: .normal)
            }
            currentButton.backgroundColor = currentSymptom.color
        }
    }
    @objc func symptomChanged(_ sender: UIButton) {
        guard let index = symptomButtons.firstIndex(of: sender) else {
            preconditionFailure("Unable to find the tapped button in the buttons array.")
        }
        currentSymptom = symptoms[index]
    }
    @IBOutlet var symptomSelector: UIStackView!
    var symptomButtons: [UIButton] = [] {
        didSet {
            oldValue.forEach { $0.removeFromSuperview() }
            symptomButtons.forEach { symptomSelector.addArrangedSubview($0) }
        }
    }
    var pet: Pet! {
        didSet {
            navigationItem.title = pet.name
        }
    }
    var symptomConfigurable: SymptomConfigurable!
    @IBAction func addSymptom(_ sender: UIButton) {
        guard let currentSymptom = currentSymptom else {
            return
        }
        let newSymptom = SymptomLog(symptom: currentSymptom.name, timestamp: Date())
        symptomConfigurable.add(symptomLog: newSymptom)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        symptoms = [.convulsed, .eat, .insomnia, .grunted, .diarrhea, .puked, .sleep]
        currentSymptom = symptoms.first
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "symptomList":
            guard let symptomConfigurable = segue.destination as? SymptomConfigurable else {
                preconditionFailure("View controller expected to conform to MoodsConfigurable")
            }
            let dest = segue.destination as! SymptomListViewController
            dest.gender = pet.gender
            self.symptomConfigurable = symptomConfigurable
        case "showInfo":
            let dest = segue.destination as! InfoViewController
            dest.pet = pet
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
}

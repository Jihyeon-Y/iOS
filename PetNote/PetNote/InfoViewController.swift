//
//  InfoViewController.swift
//  PetNote
//
//  Created by 윤지현 on 2022/02/22.
//

import UIKit

class InfoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var breedField: UITextField!
    @IBOutlet var genderSegue: UISegmentedControl!
    @IBOutlet var weightField: UITextField!
    @IBOutlet var photoButton: UIButton!
    var pet: Pet! {
        didSet {
            navigationItem.title = pet.name
        }
    }
    @IBAction func saveButton(_ sender: UIButton) {
        view.endEditing(true)
        if let name = nameField.text, !name.isEmpty, let breed = breedField.text, !breed.isEmpty, let weight = weightField.text, !weight.isEmpty {
            pet.name = name
            pet.birthday = datePicker.date
            pet.breed = breed
            pet.gender = genderSegue.selectedSegmentIndex
            pet.weight = weight
            navigationController?.popViewController(animated: true)
        }
    }
    func imagePicker(type: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = type
        imagePicker.delegate = self
        return imagePicker
    }
    @IBAction func addPhoto(_ sender: UIButton) {
        let alertControll = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertControll.modalPresentationStyle = .popover
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
                let imagePicker = self.imagePicker(type: .camera)
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertControll.addAction(cameraAction)
        }
        let libraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
            let imagePicker = self.imagePicker(type: .photoLibrary)
            self.present(imagePicker, animated: true, completion: nil)
        }
        alertControll.addAction(libraryAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertControll.addAction(cancelAction)
        present(alertControll, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @objc func dateChanged() {
        presentedViewController?.dismiss(animated: false, completion: nil)
        view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = pet.image
        nameField.text = pet.name
        datePicker.date = pet.birthday
        breedField.text = pet.breed
        genderSegue.selectedSegmentIndex = pet.gender
        weightField.text = pet.weight
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }
}

//
//  NewItemViewController.swift
//  ShoppingList
//
//  Created by 윤지현 on 2022/02/02.
//

import UIKit

class NewItemViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var itemStore: ItemStore!
    var newItem = Item(name: "", rate: 0, value: 0, dateBought: Date())
    @IBOutlet var nameField: UITextField!
    @IBOutlet var rateField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var imageView: UIImageView!
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.maximumFractionDigits = 0
        return nf
    }()
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .none
        return df
    }()
    @IBAction func saveItem(_ sender: UIButton) {
        view.endEditing(true)
        if let nameText = nameField.text, !nameText.isEmpty, let rateText = rateField.text, let rate = numberFormatter.number(from: rateText), let valueText = valueField.text, let value = numberFormatter.number(from: valueText) {
            newItem.name = nameText
            newItem.rate = rate.intValue
            newItem.valueInWon = value.intValue
            newItem.dateBought = datePicker.date
            if let image = imageView.image {
                imageStore.setImage(key: newItem.key, image: image)
            }
            itemStore.allItems.append(newItem)
            navigationController?.popViewController(animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.contentHorizontalAlignment = .leading
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }
    @objc func dateChanged() {
        presentedViewController?.dismiss(animated: false, completion: nil)
        nameField.resignFirstResponder()
        rateField.resignFirstResponder()
        valueField.resignFirstResponder()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    var imageStore: ImageStore!
    @IBAction func addPhoto(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.modalPresentationStyle = .popover
        alert.popoverPresentationController?.barButtonItem = sender
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
                let imagePicker = self.imagePicker(sourceType: .camera)
                self.present(imagePicker, animated: true, completion: nil)
            }
            alert.addAction(cameraAction)
        }
        let libraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
            let imagePicker = self.imagePicker(sourceType: .photoLibrary)
            imagePicker.modalPresentationStyle = .popover
            imagePicker.popoverPresentationController?.barButtonItem = sender
            self.present(imagePicker, animated: true, completion: nil)
        }
        alert.addAction(libraryAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    func imagePicker(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        return imagePicker
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == rateField {
            let newText = (rateField.text! as NSString).replacingCharacters(in: range, with: string) as String
            if let num = Int(newText) {
                return num <= 10
            }
        } else {
            return true
        }
        return true
    }
}

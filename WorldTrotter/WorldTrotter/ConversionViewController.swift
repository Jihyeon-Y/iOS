//
//  ViewController.swift
//  WorldTrotter
//
//  Created by 윤지현 on 2021/12/26.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var poundTextField: UITextField!
    @IBOutlet var meterTextField: UITextField!
    @IBOutlet var kilogramLabel: UILabel!
    @IBOutlet var feetLabel: UILabel!
    @IBOutlet var mileLabel: UILabel!
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelsiusLabel()
        }
    }
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    var poundValue: Measurement<UnitMass>? {
        didSet {
            updateKgLabel()
        }
    }
    var kilogramValue: Measurement<UnitMass>? {
        if let poundValue = poundValue {
            return poundValue.converted(to: .kilograms)
        } else {
            return nil
        }
    }
    var meterValue: Measurement<UnitLength>? {
        didSet {
            updateFtLabel()
            updateMiLabel()
        }
    }
    var feetValue: Measurement<UnitLength>? {
        if let meterValue = meterValue {
            return meterValue.converted(to: .feet)
        } else {
            return nil
        }
    }
    var mileValue: Measurement<UnitLength>? {
        if let meterValue = meterValue {
            return meterValue.converted(to: .miles)
        } else {
            return nil
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCelsiusLabel()
        updateKgLabel()
        updateFtLabel()
        updateMiLabel()
    }
    @IBAction func fahrenheitFieldEditingChanged(_ sender: UITextField) {
        if let text = sender.text, let number = numberFormatter.number(from: text) {
            fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    @IBAction func poundFieldEditingChanged(_ sender: UITextField) {
        if let text = sender.text, let number = numberFormatter.number(from: text) {
            poundValue = Measurement(value: number.doubleValue, unit: .pounds)
        } else {
            poundValue = nil
        }
    }
    @IBAction func meterFieldEditingChanged(_ sender: UITextField) {
        if let text = sender.text, let number = numberFormatter.number(from: text) {
            meterValue = Measurement(value: number.doubleValue, unit: .meters)
        } else {
            meterValue = nil
        }
    }
    @IBAction func dismissKeyBoard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
        poundTextField.resignFirstResponder()
        meterTextField.resignFirstResponder()
    }
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    func updateKgLabel() {
        if let kilogramValue = kilogramValue {
            kilogramLabel.text = numberFormatter.string(from: NSNumber(value: kilogramValue.value))
        } else {
            kilogramLabel.text = "???"
        }
    }
    func updateFtLabel() {
        if let feetValue = feetValue {
            feetLabel.text = numberFormatter.string(from: NSNumber(value: feetValue.value))
        } else {
            feetLabel.text = "???"
        }
    }
    func updateMiLabel() {
        if let mileValue = mileValue {
            mileLabel.text = numberFormatter.string(from: NSNumber(value: mileValue.value))
        } else {
            mileLabel.text = "???"
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentLocale = Locale.current
        let decimalSeperator = currentLocale.decimalSeparator ?? "."
        let existingTextHasDecimalSeperator = textField.text?.range(of: decimalSeperator)
        let replacementTextHasDecimalSeperator = string.range(of: decimalSeperator)
        if existingTextHasDecimalSeperator != nil,replacementTextHasDecimalSeperator != nil {
            return false
        } else {
            return true
        }
    }
}


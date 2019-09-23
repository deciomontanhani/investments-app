//
//  SimulationFormView.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 23/09/19.
//

import UIKit

class SimulationFormView: UIView {
    // MARK: - IBOutlets, Getters and Setters
    @IBOutlet private weak var moneyField: CurrencyField!

    @IBOutlet private weak var dueDateField: UITextField!
    var dueDateText: String? {
        get { return dueDateField.text }
        set {
            dueDateField.text = newValue
        }
    }

    @IBOutlet private weak var percentField: UITextField!
    var percentText: String? {
        get { return percentField.text }
        set {
            percentField.text = newValue
        }
    }
    @IBOutlet private weak var simulateButton: UIButton!

    // MARK: - Constants
    let datePicker = UIDatePicker()

    // MARK: - Public Methods
    func setupView() {
        simulateButton.setDisableState()
        showDatePicker()
        let fields = [percentField, dueDateField, moneyField]
        fields.forEach({ $0?.addTarget(self, action: #selector(checkEnableSimulateButton), for: .editingChanged) })
    }

    @objc
    func checkEnableSimulateButton() {
        if moneyField.doubleValue > 0 && percentText != "" && dueDateText != "" {
            simulateButton.setEnableState()
        } else {
            simulateButton.setDisableState()
        }
    }

    func showDatePicker() {
        //Formate Date
        datePicker.locale = Locale(identifier: "pt-br")
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()

        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace,
                                          target: nil,
                                          action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel",
                                           style: .plain,
                                           target: self,
                                           action: #selector(cancelDatePicker))

        toolbar.setItems([doneButton, spaceButton, cancelButton], animated: false)

        dueDateField.inputAccessoryView = toolbar
        dueDateField.inputView = datePicker
    }

    @objc
    func donedatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dueDateField.text = formatter.string(from: datePicker.date)
        endEditing(true)
    }

    @objc
    func cancelDatePicker() {
        endEditing(true)
    }
}

extension SimulationFormView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }

        return false
    }
}

//
//  SimulationFormView.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 23/09/19.
//

import UIKit

class SimulationFormView: UIView {
    // MARK: - IBOutlets, Getters and Setters
    @IBOutlet weak var moneyField: CurrencyField!
    @IBOutlet private weak var dueDateField: UITextField!
    var dueDateText: String?
    @IBOutlet weak var percentField: UITextField!
    @IBOutlet weak var simulateButton: UIButton!

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
        if moneyField.doubleValue > 0 && percentField.text != "" && dueDateText != "" {
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
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePicker))
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
    func doneDatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dueDateField.text = formatter.string(from: datePicker.date)
        formatter.dateFormat = "yyyy-MM-dd"
        dueDateText = formatter.string(from: datePicker.date)
        endEditing(true)
    }

    @objc
    func cancelDatePicker() {
        endEditing(true)
    }
}

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
    @IBOutlet weak var percentField: PercentField!
    @IBOutlet weak var simulateButton: UIButton!

    // MARK: - Constants
    let datePicker = UIDatePicker()

    // MARK: - Public Methods
    func setupView() {
        simulateButton.setDisableState()
        showDatePicker()
        let fields = [percentField, dueDateField, moneyField]
        fields.forEach({ $0?.addTarget(self,
                                       action: #selector(checkEnableSimulateButton),
                                       for: UIControl.Event.allEditingEvents) })
    }

    @objc
    func checkEnableSimulateButton() {
        if moneyField.doubleValue > 0
            && percentField.doubleValue > 0
            && dueDateText != ""
            && dueDateField.text != "" {
            simulateButton.setEnableState()
        } else {
            simulateButton.setDisableState()
        }
    }

    func getModel() -> SimulationQueryRequest? {
        guard moneyField.doubleValue > 0, let date = dueDateText else {
            return nil
        }

        return SimulationQueryRequest(investedAmount: moneyField.doubleValue,
                                      rate: percentField.percentageValue,
                                      maturityDate: date)
    }

    func clearFields() {
        moneyField.text = "0"
        moneyField.editingChanged()
        dueDateField.text = ""
        dueDateText = nil
        datePicker.date = Date()
        percentField.text = ""
        simulateButton.setDisableState()
    }

    func showDatePicker() {
        //Formate Date
        datePicker.accessibilityIdentifier = Localizable.datePickerIdentifier.localize()
        datePicker.locale = Locale(identifier: Localizable.brasilLocale.localize())
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()

        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: Localizable.doneButtonDatePicker.localize(),
                                         style: .plain,
                                         target: self,
                                         action: #selector(doneDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                                          target: nil,
                                          action: nil)
        let cancelButton = UIBarButtonItem(title: Localizable.cancelButtonDatePicker.localize(),
                                           style: .plain,
                                           target: self,
                                           action: #selector(cancelDatePicker))

        toolbar.setItems([doneButton, spaceButton, cancelButton], animated: false)

        dueDateField.inputAccessoryView = toolbar
        dueDateField.inputView = datePicker
    }

    @objc
    func doneDatePicker() {
        let formatter = DateFormatter.appDateFormatter(withFormat: .ddMMyyyy)
        dueDateField.text = formatter.string(from: datePicker.date)
        let apiFormatter = DateFormatter.appDateFormatter(withFormat: .yyyyMMdd)
        dueDateText = apiFormatter.string(from: datePicker.date)
        endEditing(true)
    }

    @objc
    func cancelDatePicker() {
        endEditing(true)
    }
}

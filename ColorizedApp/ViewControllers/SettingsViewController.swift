//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Ilya Kozhevnikov on 25.06.2022.
//

import UIKit

class SettingsViewController: UIViewController {

//    MARK: initialisation of variables
    
    @IBOutlet var colorScreenView: UIView!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    var viewColor: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
//    MARK: View Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateTF()
        
        colorScreenView.layer.cornerRadius = 15
        
        getInitialColorPositions()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
//    MARK: IB Actions
    
    @IBAction func sliderChange() {
        viewColorUpdate()
    }
    
    @IBAction func saveButtonTouched() {
        viewColor = colorScreenView.backgroundColor
        delegate.updateBackgroundColor(with: viewColor)
        dismiss(animated: true)
    }
    
//   MARK: Private methods
    
    private func delegateTF() {
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
    }
    
    private func getInitialColorPositions() {
        let ciColor = CIColor(color: viewColor)
        
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
                
        viewColorUpdate()
    }
    
    private func updateText(on textFields: UITextField...) {
        let ciColor = CIColor(color: viewColor)
        
        textFields.forEach { textField in
            switch textField {
                
            case redTextField:
                textField.text = String(
                    format: "%.2f",
                    ciColor.red
                )
            case greenTextField:
                textField.text = String(
                    format: "%.2f",
                    ciColor.green
                )
            default:
                textField.text = String(
                    format: "%.2f",
                    ciColor.blue
                )
            }
        }
    }
        
    private func updateText(on labels: UILabel...) {
        labels.forEach { label in
            switch label {
                
            case redValueLabel:
                label.text = redTextField.text
            case greenValueLabel:
                label.text = greenTextField.text
            default:
                label.text = blueTextField.text
            }
        }
    }

    private func viewColorUpdate() {

        viewColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: CGFloat(1)
        )
        
        colorScreenView.backgroundColor = viewColor
        
        updateText(on: redTextField, greenTextField, blueTextField)
        updateText(on: redValueLabel, greenValueLabel, blueValueLabel)
    }
}

//   MARK: Extension UITextFieldDelegate

extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard var textFieldValue = Float(textField.text!) else { return }
        
        if textFieldValue > 1 {
            textFieldValue = 1
        } else if textFieldValue < 0 {
            textFieldValue = 0
        }
        
        switch textField {
        case redTextField:
            redSlider.setValue(textFieldValue, animated: true)
        case greenTextField:
            greenSlider.setValue(textFieldValue, animated: true)
        default:
            blueSlider.setValue(textFieldValue, animated: true)
        }
        
        viewColorUpdate()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        textField.inputAccessoryView = keyboardToolbar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(didTapDone)
        )
        
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
}

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
    
//    MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateTF()
        
        colorScreenView.layer.cornerRadius = 15
        
        getInitialColorPositions()
    }
    
//    MARK: sliders change functions
    
    @IBAction func sliderChange() {
        viewColorUpdate()
    }
    
//   MARK: save button action
    
    @IBAction func saveButtonTouched() {
        viewColor = colorScreenView.backgroundColor
        delegate.updateBackgroundColor(with: viewColor)
        dismiss(animated: true)
    }
    
//   MARK: delegate initialisation for TextFields
    
    private func delegateTF() {
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
    }
    
//   MARK: get Initial Position for Sliders, TextFields, Labels

    private func getInitialColorPositions() {
        redSlider.value = getComponentValue(.red, from: viewColor)
        greenSlider.value = getComponentValue(.green, from: viewColor)
        blueSlider.value = getComponentValue(.blue, from: viewColor)
                
        viewColorUpdate()
    }
    
//   MARK: Text update on Labels
    
    private func labelTextUpdate(on labels: UILabel...) {
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
    
//   MARK: Text update on TextFields
    
    private func updateTF(on textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
                
            case redTextField:
                textField.text = String(
                    format: "%.2f",
                    getComponentValue(.red, from: viewColor)
                )
            case greenTextField:
                textField.text = String(
                    format: "%.2f",
                    getComponentValue(.green, from: viewColor))
            default:
                textField.text = String(
                    format: "%.2f",
                    getComponentValue(.blue, from: viewColor))
            }
        }
    }
    
//   MARK: ViewColor update

    private func viewColorUpdate() {

        viewColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: CGFloat(1)
        )
        
        colorScreenView.backgroundColor = viewColor
        
        updateTF(on: redTextField, greenTextField, blueTextField)
        labelTextUpdate(on: redValueLabel, greenValueLabel, blueValueLabel)
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
            redSlider.value = textFieldValue
        case greenTextField:
            greenSlider.value = textFieldValue
        default:
            blueSlider.value = textFieldValue
        }
        
        viewColorUpdate()
    }
}

//   MARK: Extension color decomposition to Red, Green, Blue

extension SettingsViewController {
    enum ColorComponent {
        case red
        case green
        case blue
    }
    
    private func getComponentValue(_ component: ColorComponent, from color: UIColor) -> Float {
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        color.getRed(
            &red,
            green: &green,
            blue: &blue,
            alpha: &alpha
        )
        
        switch component {
        case .red:
            return Float(red)
        case .green:
            return Float(green)
        case .blue:
            return Float(blue)
        }
    }
}


//    MARK: Extension keyboard hide
extension SettingsViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

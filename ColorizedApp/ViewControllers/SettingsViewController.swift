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
    
    var viewColor: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
//    MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorScreenView.layer.cornerRadius = 15
        colorScreenView.backgroundColor = viewColor
        
        getRGBColor()
    }
    
//    MARK: sliders change functions
    
    @IBAction func sliderChange(slider: UISlider) {
        
        switch slider {
        case redSlider:
            updateText(on: redValueLabel)
        case greenSlider:
            updateText(on: greenValueLabel)
        default:
            updateText(on: blueValueLabel)
        }
        
        colorScreenAdjustment()
    }
    
//   MARK: save button action
    
    @IBAction func saveButtonTouched() {
        viewColor = colorScreenView.backgroundColor
        delegate.updateBackgroundColor(with: viewColor)
        dismiss(animated: true)
    }
    
//   MARK: private functions
    
    private func getRGBColor() {
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        
        viewColor.getRed(
            &red,
            green: &green,
            blue: &blue,
            alpha: &alpha
        )
        
        initialSlidersPosition(
            red: Float(red),
            green: Float(green),
            blue: Float(blue)
        )

    }
    
    private func initialSlidersPosition(red: Float, green: Float, blue: Float) {
        redSlider.value = red
        greenSlider.value = green
        blueSlider.value = blue
        
        updateText(on: redValueLabel, greenValueLabel, blueValueLabel)
    }
    
    private func updateText(on labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redValueLabel:
                label.text = stringFrom(redSlider)
            case greenValueLabel:
                label.text = stringFrom(greenSlider)
            default:
                label.text = stringFrom(blueSlider)
            }
        }
    }
    
    private func stringFrom(_ slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func colorScreenAdjustment() {

        colorScreenView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: CGFloat(1)
        )

    }
}


//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Ilya Kozhevnikov on 25.06.2022.
//

import UIKit

class ViewController: UIViewController {

//    MARK: initialisation of variables
    
    @IBOutlet var colorScreenView: UIView!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
//    MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorScreenView.layer.cornerRadius = 15
        getInitialColor()
    }
    
//    MARK: sliders change functions
    
    @IBAction func sliderChange(slider: UISlider) {
        
        switch slider {
        case redSlider:
            updateText(on: redValueLabel, with: slider.value)
        case greenSlider:
            updateText(on: greenValueLabel, with: slider.value)
        default:
            updateText(on: blueValueLabel, with: slider.value)
        }
        
        colorScreenAdjustment()
    }
    
//   MARK: private functions
    
    private func getInitialColor() {
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        colorScreenView.backgroundColor!.getRed(
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
        
        updateText(on: redValueLabel, with: red)
        updateText(on: greenValueLabel, with: green)
        updateText(on: blueValueLabel, with: blue)
    }
    
    private func updateText(on label: UILabel, with value: Float) {
        label.text = String(format: "%.2f", value)
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


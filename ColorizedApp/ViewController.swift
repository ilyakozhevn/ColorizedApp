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
        colorScreenAdjustment()
        }
    
//    MARK: sliders change functions
    
    @IBAction func redSliderChange() {
        textChange(of: redValueLabel, to: redSlider.value)
        colorScreenAdjustment()
    }
    
    @IBAction func greenSliderChange() {
        textChange(of: greenValueLabel, to: greenSlider.value)
        colorScreenAdjustment()
    }
    @IBAction func blueSliderChange() {
        textChange(of: blueValueLabel, to: blueSlider.value)
        colorScreenAdjustment()
    }
    
//   MARK: private functions
    
    private func colorScreenAdjustment() {

        colorScreenView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: CGFloat(1)
        )
    }
    
    private func textChange(of label: UILabel, to value: Float) {
        label.text = String(format: "%.2f", value)
    }
}


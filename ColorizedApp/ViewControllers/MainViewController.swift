//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Ilya Kozhevnikov on 13.07.2022.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func updateBackgroundColor(with color: UIColor)
}

class MainViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingVC = segue.destination as? SettingsViewController else { return }
        settingVC.viewColor = view.backgroundColor
        settingVC.delegate = self
    }

    @IBAction func settingsButtonTouched(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showSettings", sender: nil)
    }

}

// MARK: SettingsViewControllerDelegate
extension MainViewController: SettingsViewControllerDelegate {
    func updateBackgroundColor(with color: UIColor) {
        view.backgroundColor = color
    }
}

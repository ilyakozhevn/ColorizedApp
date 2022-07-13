//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Ilya Kozhevnikov on 13.07.2022.
//

import UIKit

//protocol SettingsViewControllerDelegate

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingVC = segue.destination as? SettingsViewController else { return }
        settingVC.color = self.view.backgroundColor
    }

    @IBAction func settingsButtonTouched(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showSettings", sender: nil)
    }

}

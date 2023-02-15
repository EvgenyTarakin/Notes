//
//  UIViewControllerExtension.swift
//  Notes
//
//  Created by Евгений Таракин on 08.02.2023.
//

import UIKit

extension UIViewController {
    func setBackgroundColor() {
        if UserDefaults.standard.bool(forKey: "isDark") {
            self.view.backgroundColor = .black
        } else {
            self.view.backgroundColor = .white
        }
    }
    
    func setSettingsButton() {
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .done, target: self, action: #selector(tapSettingsButton))
        navigationItem.rightBarButtonItem = settingsButton
    }
    
    @objc private func tapSettingsButton() {
        let controller = SettingsController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

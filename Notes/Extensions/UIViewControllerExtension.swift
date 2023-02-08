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
}

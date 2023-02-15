//
//  UITextFieldExtension.swift
//  Notes
//
//  Created by Евгений Таракин on 15.02.2023.
//

import UIKit

extension UITextField {
    func setButtonOnKeyboard() {
        self.returnKeyType = .next
        let keyboardToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        keyboardToolbar.backgroundColor = .clear
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let closeButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(closeKeyboard))
        keyboardToolbar.items = [flexBarButton ,closeButton]
        self.inputAccessoryView = keyboardToolbar
        self.autocorrectionType = .no
        self.spellCheckingType = .no
    }
    
    @objc private func closeKeyboard() {
        endEditing(true)
    }
}

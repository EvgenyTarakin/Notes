//
//  NewNoteView.swift
//  Notes
//
//  Created by Евгений Таракин on 14.02.2023.
//

import UIKit

// MARK: - protocol
protocol NewNoteViewDelegate: AnyObject {
    
}

final class NewNoteView: UIView {
    
//    MARK: - property
    weak var delegate: NewNoteViewDelegate?
    
    private lazy var nameNoteTextFiled: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.textAlignment = .right
        textField.setButtonOnKeyboard()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.setButtonOnKeyboard()
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
//    MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//    MARK: - private func
    private func commonInit() {
        registerKeyboardNotifications()
        addSubview(nameNoteTextFiled)
        addSubview(textView)
        NSLayoutConstraint.activate([
            nameNoteTextFiled.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            nameNoteTextFiled.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            nameNoteTextFiled.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            nameNoteTextFiled.heightAnchor.constraint(equalToConstant: 42),
            
            textView.topAnchor.constraint(equalTo: nameNoteTextFiled.bottomAnchor, constant: 16),
            textView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            textView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
    
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
//    MARK: - func
    func configurate(name: String, text: String) {
        nameNoteTextFiled.text = name
        textView.text = text
    }
    
    func updateFont() {
        nameNoteTextFiled.font = UIFont.systemFont(ofSize: (Settings().size as! CGFloat) * 1.15, weight: Settings().type as! UIFont.Weight)
        textView.font = UIFont.systemFont(ofSize: Settings().size as! CGFloat, weight: Settings().type as! UIFont.Weight)
    }

//    MARK: - obj-c
    @objc private func keyboardWillShow(_ sender: Notification) {
        if let keyboardSize = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            var inset = textView.contentInset
            inset.bottom = keyboardSize.height
            textView.contentInset.bottom = inset.bottom + 8
        }
    }
   
    @objc private func keyboardWillHide() {
        textView.contentInset = .zero
    }
    
//    MARK: - deinit
    deinit {
        removeKeyboardNotifications()
    }
    
}

extension NewNoteView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == ""  {
            textField.text = "Без названия"
        }
        textView.becomeFirstResponder()
        return true
    }
}

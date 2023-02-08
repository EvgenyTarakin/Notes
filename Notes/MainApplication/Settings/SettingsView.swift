//
//  SettingsView.swift
//  Notes
//
//  Created by Евгений Таракин on 07.02.2023.
//

import UIKit

// MARK: - protocol
protocol SettingsViewDelegate: AnyObject {
    func setDarkTheme()
    func setLightTheme()
}

class SettingsView: UIView {
    
//    MARK: - property
    weak var delegate: SettingsViewDelegate?
    
    private lazy var themeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelTheme, switchTheme])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var labelTheme: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.text = "Темная тема"
        
        return label
    }()
    
    private lazy var switchTheme: UISwitch = {
        let switchTheme = UISwitch()
        switchTheme.onTintColor = .systemBlue
        switchTheme.addTarget(self, action: #selector(changeTheme), for: .valueChanged)
        
        return switchTheme
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
        addSubview(themeStackView)
        
        if UserDefaults.standard.bool(forKey: "isDark") {
            switchTheme.isOn = true
            labelTheme.text = "Темная тема"
        } else {
            switchTheme.isOn = false
            labelTheme.text = "Cветлая тема"
        }
    
        NSLayoutConstraint.activate([
            themeStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            themeStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            themeStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            themeStackView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
//    MARK: - obj-c
    @objc private func changeTheme(_ sender: UISwitch) {
        if sender.isOn {
            labelTheme.text = "Темная тема"
            delegate?.setDarkTheme()
        } else {
            labelTheme.text = "Cветлая тема"
            delegate?.setLightTheme()
        }
    }

}

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
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [themeStackView, fontStackView])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var themeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelTheme, switchTheme])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.alignment = .center
        
        return stackView
    }()
    
    private lazy var labelTheme: UILabel = {
        let label = UILabel()
        label.text = "Темная тема"
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    private lazy var switchTheme: UISwitch = {
        let switchTheme = UISwitch()
        switchTheme.onTintColor = .systemBlue
        switchTheme.addTarget(self, action: #selector(changeTheme), for: .valueChanged)
        
        return switchTheme
    }()
    
    private lazy var fontStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelFont, switchFont])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.alignment = .center
        
        return stackView
    }()
    
    private lazy var labelFont: UILabel = {
        let label = UILabel()
        label.text = "Обычный шрифт"
        label.adjustsFontForContentSizeCategory = true

        return label
    }()
    
    private lazy var switchFont: UISwitch = {
        let switchTheme = UISwitch()
        switchTheme.onTintColor = .systemBlue
        switchTheme.addTarget(self, action: #selector(changeFont), for: .valueChanged)
        
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
        addSubview(mainStackView)
        
        if UserDefaults.standard.bool(forKey: "isDark") {
            switchTheme.isOn = true
            labelTheme.text = "Темная тема"
        } else {
            switchTheme.isOn = false
            labelTheme.text = "Cветлая тема"
        }
    
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            mainStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            mainStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            themeStackView.heightAnchor.constraint(equalToConstant: 44),
            
            labelTheme.heightAnchor.constraint(equalTo: themeStackView.heightAnchor),
            labelFont.heightAnchor.constraint(equalTo: fontStackView.heightAnchor)
        ])
    }
    
//    MARK: - func
    func updateLabel() {
        let font = UIFont.systemFont(ofSize: 20 * Font.fontCofficient)
        labelTheme.font = font
        labelFont.font = font
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
    
    @objc private func changeFont(_ sender: UISwitch) {
        
    }

}

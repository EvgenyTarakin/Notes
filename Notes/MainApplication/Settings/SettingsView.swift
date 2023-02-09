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
    func setBoldFont()
    func setRegularFont()
    func setFontSize(_ size: CGFloat)
}

class SettingsView: UIView {
    
//    MARK: - property
    weak var delegate: SettingsViewDelegate?
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [themeStackView, fontTypeStackView])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var themeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [themeLabel, themeSwitch])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.alignment = .center
        
        return stackView
    }()
    
    private lazy var themeLabel: UILabel = {
        let label = UILabel()
        label.text = "Темная тема"
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    private lazy var themeSwitch: UISwitch = {
        let switchTheme = UISwitch()
        switchTheme.onTintColor = .systemBlue
        switchTheme.addTarget(self, action: #selector(changeTheme), for: .valueChanged)
        
        return switchTheme
    }()
    
    private lazy var fontTypeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [fontTypeLabel, fontTypeSwitch])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.alignment = .center
        
        return stackView
    }()
    
    private lazy var fontTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Жирный шрифт"
        label.adjustsFontForContentSizeCategory = true

        return label
    }()
    
    private lazy var fontTypeSwitch: UISwitch = {
        let switchTheme = UISwitch()
        switchTheme.onTintColor = .systemBlue
        switchTheme.addTarget(self, action: #selector(changeTypeFont), for: .valueChanged)
        
        return switchTheme
    }()
    
    private lazy var fontSizeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [fontSizeLabel, fontSizeSlider])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var fontSizeLabel: UILabel = {
        let label = UILabel()
        label.text = "Размер шрифта"
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    private lazy var fontSizeSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 10
        slider.maximumValue = 35
        slider.addTarget(self, action: #selector(changeSizeFont), for: .valueChanged)
        
        return slider
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
        addSubview(fontSizeStackView)
    
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            mainStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            mainStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            themeStackView.heightAnchor.constraint(equalToConstant: 44),
            
            themeLabel.heightAnchor.constraint(equalTo: themeStackView.heightAnchor),
            fontTypeLabel.heightAnchor.constraint(equalTo: fontTypeStackView.heightAnchor),
            
            fontSizeStackView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 48),
            fontSizeStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            fontSizeStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -32),
            fontSizeLabel.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func updateFonts(size: CGFloat, type: UIFont.Weight) {
        themeLabel.font = .systemFont(ofSize: size, weight: type)
        fontTypeLabel.font = .systemFont(ofSize: size, weight: type)
        fontSizeLabel.font = .systemFont(ofSize: size, weight: type)
    }
    
//    MARK: - func 
    func setupSettings(theme: Bool, size: CGFloat, type: UIFont.Weight) {
        fontSizeSlider.value = Float(size)
        updateFonts(size: size, type: type)
        if theme {
            themeSwitch.isOn = true
        } else {
            themeSwitch.isOn = false
        }
        if type == .bold {
            fontTypeSwitch.isOn = true
        } else {
            fontTypeSwitch.isOn = false
        }
    }
    
//    MARK: - obj-c
    @objc private func changeTheme(_ sender: UISwitch) {
        if sender.isOn {
            delegate?.setDarkTheme()
        } else {
            delegate?.setLightTheme()
        }
    }
    
    @objc private func changeTypeFont(_ sender: UISwitch) {
        if sender.isOn {
            updateFonts(size: themeLabel.font.pointSize, type: .bold)
            delegate?.setBoldFont()
        } else {
            updateFonts(size: themeLabel.font.pointSize, type: .regular)
            delegate?.setRegularFont()
        }
    }
    
    @objc private func changeSizeFont( _ sender: UISlider) {
        let size = CGFloat(Int(sender.value))
        if fontTypeSwitch.isOn {
            updateFonts(size: size, type: .bold)
        } else {
            updateFonts(size: size, type: .regular)
        }
        delegate?.setFontSize(size)
    }

}

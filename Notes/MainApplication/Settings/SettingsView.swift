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
    func setFontSize(_ size: CGFloat)
}

class SettingsView: UIView {
    
//    MARK: - property
    weak var delegate: SettingsViewDelegate?
    private lazy var fontSize = UserDefaults.standard.object(forKey: "fontSize") as! CGFloat
    
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
        label.font = .systemFont(ofSize: CGFloat(fontSize))
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    private lazy var themeSwitch: UISwitch = {
        let switchTheme = UISwitch()
        switchTheme.onTintColor = .systemBlue
        switchTheme.addTarget(self, action: #selector(changeTheme), for: .valueChanged)
        
        return switchTheme
    }()
    
    private lazy var fontStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [fontLabel, fontSwitch])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.alignment = .center
        
        return stackView
    }()
    
    private lazy var fontLabel: UILabel = {
        let label = UILabel()
        label.text = "Обычный шрифт"
        label.font = .systemFont(ofSize: CGFloat(fontSize))
        label.adjustsFontForContentSizeCategory = true

        return label
    }()
    
    private lazy var fontSwitch: UISwitch = {
        let switchTheme = UISwitch()
        switchTheme.onTintColor = .systemBlue
        switchTheme.addTarget(self, action: #selector(changeFont), for: .valueChanged)
        
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
        label.font = .systemFont(ofSize: CGFloat(fontSize))
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    private lazy var fontSizeSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 10
        slider.maximumValue = 35
        slider.value = Float(fontSize)
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
        
        if UserDefaults.standard.bool(forKey: "isDark") {
            themeSwitch.isOn = true
        } else {
            themeSwitch.isOn = false
        }
    
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            mainStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            mainStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            themeStackView.heightAnchor.constraint(equalToConstant: 44),
            
            themeLabel.heightAnchor.constraint(equalTo: themeStackView.heightAnchor),
            fontLabel.heightAnchor.constraint(equalTo: fontStackView.heightAnchor),
            
            fontSizeStackView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 48),
            fontSizeStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            fontSizeStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -32),
            fontSizeLabel.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
//    MARK: - func
    func updateLabel() {
//        let font = UIFont.systemFont(ofSize: Font.fontValue)
//        themeLabel.font = font
//        fontLabel.font = font
    }
    
//    MARK: - obj-c
    @objc private func changeTheme(_ sender: UISwitch) {
        if sender.isOn {
            delegate?.setDarkTheme()
        } else {
            delegate?.setLightTheme()
        }
    }
    
    @objc private func changeFont(_ sender: UISwitch) {
        
    }
    
    @objc private func changeSizeFont( _ sender: UISlider) {
        let value = Int(sender.value)
        let font = UIFont.systemFont(ofSize: CGFloat(value))
        themeLabel.font = font
        fontLabel.font = font
        fontSizeLabel.font = font
        
        delegate?.setFontSize(CGFloat(value))
    }

}

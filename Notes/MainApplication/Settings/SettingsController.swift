//
//  SettingsController.swift
//  Notes
//
//  Created by Евгений Таракин on 07.02.2023.
//

import UIKit

class SettingsController: UIViewController {
    
//    MARK: - property
    private var settings = Settings()
    
    private lazy var settingsView: SettingsView = {
        let settingsView = SettingsView()
        settingsView.delegate = self
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        
        return settingsView
    }()
    
//    MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
//    MARK: - private func
    private func commonInit() {
        setBackgroundColor()
        setSettings()
        
        title = "Настройки"
        navigationItem.largeTitleDisplayMode = .never
        
        view.addSubview(settingsView)
        NSLayoutConstraint.activate([
            settingsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            settingsView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            settingsView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    private func setSettings() {
        settingsView.setupSettings(theme: settings.theme, size: settings.size as! CGFloat, type: settings.type as! UIFont.Weight)
    }

}

// MARK: - extension
extension SettingsController: SettingsViewDelegate {
    func setDarkTheme() {
        navigationController?.overrideUserInterfaceStyle = .dark
        UserDefaults.standard.set(true, forKey: "isDark")
        UserDefaults.standard.synchronize()
        setBackgroundColor()
    }
    
    func setLightTheme() {
        navigationController?.overrideUserInterfaceStyle = .light
        UserDefaults.standard.set(false, forKey: "isDark")
        UserDefaults.standard.synchronize()
        setBackgroundColor()
    }
    
    func setRegularFont() {
        UserDefaults.standard.set(UIFont.Weight.regular, forKey: "fontType")
        UserDefaults.standard.synchronize()
    }
    
    func setBoldFont() {
        UserDefaults.standard.set(UIFont.Weight.bold, forKey: "fontType")
        UserDefaults.standard.synchronize()
    }
    
    func setFontSize(_ size: CGFloat) {
        UserDefaults.standard.set(size, forKey: "fontSize")
        UserDefaults.standard.synchronize()
    }
}

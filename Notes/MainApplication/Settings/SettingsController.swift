//
//  SettingsController.swift
//  Notes
//
//  Created by Евгений Таракин on 07.02.2023.
//

import UIKit

class SettingsController: UIViewController {
    
//    MARK: - property
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        settingsView.updateLabel()
    }
    
//    MARK: - private func
    private func commonInit() {
        setBackgroundColor()
        
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
}

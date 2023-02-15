//
//  Settings.swift
//  Notes
//
//  Created by Евгений Таракин on 08.02.2023.
//

import UIKit

final class Settings {
    lazy var theme = UserDefaults.standard.bool(forKey: "isDark")
    lazy var size = UserDefaults.standard.object(forKey: "fontSize") ?? CGFloat(20) 
    lazy var type = UserDefaults.standard.object(forKey: "fontType") ?? UIFont.Weight.regular
}

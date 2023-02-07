//
//  TypeButton.swift
//  Notes
//
//  Created by Евгений Таракин on 07.02.2023.
//

import UIKit

enum TypeButton {
    case trash
    case addFolder
    
    var image: UIImage? {
        switch self {
        case .trash: return UIImage(systemName: "trash.fill")
        case .addFolder: return UIImage(systemName: "folder.fill.badge.plus")
        }
    }
}
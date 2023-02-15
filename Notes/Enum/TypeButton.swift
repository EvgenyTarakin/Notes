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
    case addNote
    
    var image: UIImage? {
        switch self {
        case .trash: return UIImage(systemName: "trash")
        case .addFolder: return UIImage(systemName: "folder.badge.plus")
        case .addNote: return UIImage(systemName: "square.and.pencil")
        }
    }
}

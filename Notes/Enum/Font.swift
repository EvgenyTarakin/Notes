//
//  Font.swift
//  Notes
//
//  Created by Евгений Таракин on 08.02.2023.
//

import UIKit

enum Font {
    static var fontCofficient: CGFloat {
        let coefficient = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.systemFont(ofSize: 32)).pointSize / 32
        if coefficient > 2 {
            return CGFloat(1.9)
        }
        return coefficient
    }
}

//
//  Note.swift
//  Notes
//
//  Created by Евгений Таракин on 14.02.2023.
//

import Foundation

final public class Note: NSObject {
    let name: String
    let date: String
    let text: String
    
    init(name: String, date: String, text: String) {
        self.name = name
        self.date = date
        self.text = text
    }
}

//
//  Label.swift
//  Notes
//
//  Created by Евгений Таракин on 14.02.2023.
//

import UIKit

class Label: UIView {
    
//    MARK: - TypeLabel
    enum TypeLabel {
        case folders
        case notes
        
        var startTitle: String {
            switch self {
            case .folders: return "пап"
            case .notes: return "замет"
            }
        }
    }
    
//    MARK: - property
    private var type: TypeLabel?
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

//    MARK: - init
    init(frame: CGRect, type: TypeLabel) {
        super.init(frame: frame)
        self.type = type
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//    MARK: - private func
    private func commonInit() {
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.leftAnchor.constraint(equalTo: leftAnchor),
            label.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
//    MARK: - func
    func configurate(_ count: Int) {
        switch count {
        case 1: label.text = "\(count) \(type?.startTitle ?? "")ка"
        case 2...4: label.text = "\(count) \(type?.startTitle ?? "")ки"
        default: label.text = "\(count) \(type?.startTitle ?? "")ок"
        }
    }

}

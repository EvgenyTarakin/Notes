//
//  FolderCell.swift
//  Notes
//
//  Created by Евгений Таракин on 06.02.2023.
//

import UIKit

class FolderCell: UITableViewCell {
    
//    MARK: - property
    static let reuseIdentifier = String(describing: FolderCell.self)
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        
        return label
    }()
    
//    MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//    MARK: - private func
    private func commonInit() {
        selectionStyle = .none
        
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20)
        ])
    }
    
//    MARK: - func
    func configurate(folder: Folder) {
        nameLabel.text = folder.name
    }

}

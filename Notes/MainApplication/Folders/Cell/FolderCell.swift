//
//  FolderCell.swift
//  Notes
//
//  Created by Евгений Таракин on 06.02.2023.
//

import UIKit

final class FolderCell: UITableViewCell {
    
//    MARK: - property
    static let reuseIdentifier = String(describing: FolderCell.self)
    
    private lazy var folderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "folder")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        addSubview(folderImageView)
        addSubview(dateLabel)
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            folderImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            folderImageView.heightAnchor.constraint(equalToConstant: 48),
            folderImageView.widthAnchor.constraint(equalTo: folderImageView.heightAnchor),
            folderImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            nameLabel.leftAnchor.constraint(equalTo: folderImageView.rightAnchor, constant: 16),
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -80),
            
            dateLabel.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 8),
            dateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
//    MARK: - func
    func configurate(folder: Folder, fontSize: CGFloat, fontType: UIFont.Weight) {
        nameLabel.text = folder.name
        nameLabel.font = UIFont.systemFont(ofSize: fontSize, weight: fontType)
        
        dateLabel.text = folder.date
        dateLabel.font = UIFont.systemFont(ofSize: fontSize / 2, weight: fontType)
    }

}

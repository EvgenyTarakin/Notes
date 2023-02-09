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
    
    private lazy var folderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "folder.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
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
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            folderImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            folderImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            folderImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            folderImageView.widthAnchor.constraint(equalTo: folderImageView.heightAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            nameLabel.leftAnchor.constraint(equalTo: folderImageView.rightAnchor, constant: 16),
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20)
        ])
    }
    
//    MARK: - func
    func configurate(folder: Folder, fontSize: CGFloat, fontType: UIFont.Weight) {
        nameLabel.text = folder.name
        nameLabel.font = UIFont.systemFont(ofSize: fontSize, weight: fontType)
    }

}

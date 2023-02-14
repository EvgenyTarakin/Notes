//
//  NoteCell.swift
//  Notes
//
//  Created by Евгений Таракин on 12.02.2023.
//

import UIKit

class NoteCell: UITableViewCell {

//    MARK: - property
    static let reuseIdentifier = String(describing: NoteCell.self)
    
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
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//    MARK: - private func
    private func commonInit() {
        
    }

}

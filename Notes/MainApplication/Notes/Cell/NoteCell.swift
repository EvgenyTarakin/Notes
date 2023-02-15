//
//  NoteCell.swift
//  Notes
//
//  Created by Евгений Таракин on 12.02.2023.
//

import UIKit

final class NoteCell: UITableViewCell {

//    MARK: - property
    static let reuseIdentifier = String(describing: NoteCell.self)
    
    private lazy var noteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "note.text")
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
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//    MARK: - private func
    private func commonInit() {
        selectionStyle = .none
        
        addSubview(noteImageView)
        addSubview(nameLabel)
        addSubview(dateLabel)
        NSLayoutConstraint.activate([
            noteImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            noteImageView.heightAnchor.constraint(equalToConstant: 48),
            noteImageView.widthAnchor.constraint(equalTo: noteImageView.heightAnchor),
            noteImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            nameLabel.leftAnchor.constraint(equalTo: noteImageView.rightAnchor, constant: 16),
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -80),
            
            dateLabel.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 8),
            dateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
//    MARK: - func
    func configurate(note: Note, fontSize: CGFloat, fontType: UIFont.Weight) {
        if note.name == "" {
            nameLabel.text = "Без названия"
        } else {
            nameLabel.text = note.name
        }
        dateLabel.text = note.date
        
        nameLabel.font = UIFont.systemFont(ofSize: fontSize, weight: fontType)
        dateLabel.font = UIFont.systemFont(ofSize: fontSize / 2, weight: fontType)
    }

}

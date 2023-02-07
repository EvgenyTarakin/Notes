//
//  Button.swift
//  Notes
//
//  Created by Евгений Таракин on 07.02.2023.
//

import UIKit

// MARK: - protocol
protocol ButtonDelegate: AnyObject {
    func didSelectButton(_ type: TypeButton)
}

class Button: UIView {
    
//    MARK: - property
    private var type: TypeButton!
    weak var delegate: ButtonDelegate?
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        
        return button
    }()

//    MARK: - init
    init(frame: CGRect, type: TypeButton) {
        super.init(frame: frame)
        self.type = type
        imageView.image = type.image
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//    MARK: - private func
    private func commonInit() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        addSubview(button)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),

            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.leftAnchor.constraint(equalTo: leftAnchor),
            button.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
//    MARK: - obj-c
    @objc private func tapButton() {
        delegate?.didSelectButton(type)
    }

}

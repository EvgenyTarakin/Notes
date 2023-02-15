//
//  NewNoteController.swift
//  Notes
//
//  Created by Евгений Таракин on 14.02.2023.
//

import UIKit

final class NewNoteController: UIViewController {
    
//    MARK: - property
    private lazy var newNoteView: NewNoteView = {
        let newNoteView = NewNoteView()
        newNoteView.delegate = self
        newNoteView.translatesAutoresizingMaskIntoConstraints = false
        
        return newNoteView
    }()

//    MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
        tabBarController?.tabBar.isHidden = true
        newNoteView.updateFont()
        setBackgroundColor()
    }
    
//    MARK: - private func
    private func commonInit() {
        setSettingsButton()
        
        view.addSubview(newNoteView)
        NSLayoutConstraint.activate([
            newNoteView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newNoteView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            newNoteView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            newNoteView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
//    MARK: - func
    func configurate(name: String = "Без названия", text: String = "", date: String) {
        newNoteView.configurate(name: name, text: text)
        title = date
    }

}

//MARK: - extension
extension NewNoteController: NewNoteViewDelegate {

}

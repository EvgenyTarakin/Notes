//
//  NotesController.swift
//  Notes
//
//  Created by Евгений Таракин on 09.02.2023.
//

import UIKit

class NotesController: UIViewController {
    
//    MARK: - property
    private var folder: Folder?
    
    private lazy var notesView: NotesView = {
        let notesView = NotesView()
        notesView.translatesAutoresizingMaskIntoConstraints = false
        
        return notesView
    }()

//    MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        tabBarController?.tabBar.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        let trashButton = Button(frame: CGRect(x: 0, y: 0, width: 80, height: 48), type: .trash)
        trashButton.delegate = self
        tabBarController?.tabBar.addSubview(trashButton)
        
        let addNewNoteButton = Button(frame: CGRect(x: view.frame.width - 80, y: 0, width: 80, height: 48), type: .addNote)
        addNewNoteButton.delegate = self
        tabBarController?.tabBar.addSubview(addNewNoteButton)
        
        setBackgroundColor()
    }
    
//    MARK: - private func
    private func commonInit() {
        setSettingsButton()
        
        view.addSubview(notesView)
        NSLayoutConstraint.activate([
            notesView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            notesView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            notesView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            notesView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
//    MARK: - obj-c

//    MARK: - func
    func configurate(_ folder: Folder) {
        self.folder = folder
        title = folder.name
    }
    
}

// MARK: - extension
extension NotesController: ButtonDelegate {
    func didSelectButton(_ type: TypeButton) {
        switch type {
        case .addNote: break
        case .trash: break
        default: break
        }
    }
}

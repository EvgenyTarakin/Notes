//
//  NotesController.swift
//  Notes
//
//  Created by Евгений Таракин on 09.02.2023.
//

import UIKit

final class NotesController: UIViewController {
    
//    MARK: - property
    private var dataManager = DataManager()
    private var folder: Folder?
    private var index: Int = 0
    
    private lazy var notesView: NotesView = {
        let notesView = NotesView()
        notesView.delegate = self
        notesView.translatesAutoresizingMaskIntoConstraints = false
        
        return notesView
    }()
    
    private lazy var countLabel: Label = {
        let label = Label(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 48), type: .notes)
        
        return label
    }()
    
    private lazy var trashButton: Button = {
        let button = Button(frame: CGRect(x: 0, y: 0, width: 80, height: 48), type: .trash)
        button.delegate = self
        
        return button
    }()
    
    private lazy var addNewNoteButton: Button = {
        let button = Button(frame: CGRect(x: view.frame.width - 80, y: 0, width: 80, height: 48), type: .addNote)
        button.delegate = self
        
        return button
    }()

//    MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tabBarController?.tabBar.isHidden = false
        tabBarController?.tabBar.subviews.forEach {
            $0.removeFromSuperview()
        }

        tabBarController?.tabBar.addSubview(countLabel)
        tabBarController?.tabBar.addSubview(trashButton)
        tabBarController?.tabBar.addSubview(addNewNoteButton)
        
        setBackgroundColor()
        notesView.updateFont()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

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
    
//    MARK: - func
    func configurate(_ folder: Folder, index: Int) {
        title = folder.name
        self.folder = folder
        self.index = index
        notesView.getTableData(folder.notes ?? [])
    }
    
////    MARK: - obj-c
//    @objc private func 
    
}

// MARK: - extension
extension NotesController: ButtonDelegate {
    func didSelectButton(_ type: TypeButton) {
        switch type {
        case .addNote:
//            dataManager.saveNote(index: index, name: "", date: "", text: "")
//            notesView.getTableData(dataManager.folders[index].notes ?? [])
            let date = NSDate()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMMM YYYY г. в hh:MM"
            formatter.locale = Locale(identifier: "ru")
            let time = formatter.string(from: date as Date)
            
            let controller = NewNoteController()
            controller.configurate(date: time)
            navigationController?.pushViewController(controller, animated: true)
        case .trash: break
        default: break
        }
    }
}

extension NotesController: NotesViewDelegate {
    func updateCountLabel(_ count: Int) {
        countLabel.configurate(count)
    }
}

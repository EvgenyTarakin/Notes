//
//  FolderViewController.swift
//  Notes
//
//  Created by Евгений Таракин on 06.02.2023.
//

import UIKit

class FoldersController: UIViewController {
    
//    MARK: - property
    private var dataManager = DataManager()

    private lazy var foldersView: FoldersView = {
        let foldersView = FoldersView()
        foldersView.delegate = self
        foldersView.translatesAutoresizingMaskIntoConstraints = false
        
        return foldersView
    }()
    
    private lazy var newFolderAlert: UIAlertController = {
        let alert = UIAlertController(title: "Создать новую папку", message: "Напишите название новой папки", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Создать", style: .default, handler: addNewFolder))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alert.addTextField()
        
        return alert
    }()
    
    private lazy var deleteAllFoldersAlert: UIAlertController = {
        let alert = UIAlertController(title: "Вы действительно хотите удалить все папки?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: deleteAllFolders))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        
        return alert
    }()
    
    private lazy var countLabel: Label = {
        let label = Label(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 48), type: .folders)
        
        return label
    }()
    
    private lazy var trashButton: Button = {
        let button = Button(frame: CGRect(x: 0, y: 0, width: 80, height: 48), type: .trash)
        button.delegate = self
        
        return button
    }()
    
    private lazy var addNewFolderButton: Button = {
        let button = Button(frame: CGRect(x: view.frame.width - 80, y: 0, width: 80, height: 48), type: .addFolder)
        button.delegate = self
        
        return button
    }()
    
//    MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        foldersView.getTableData(dataManager.folders)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        tabBarController?.tabBar.subviews.forEach {
            $0.removeFromSuperview()
        }

        tabBarController?.tabBar.addSubview(countLabel)
        tabBarController?.tabBar.addSubview(trashButton)
        tabBarController?.tabBar.addSubview(addNewFolderButton)
        
        setBackgroundColor()
        foldersView.updateFont()
    }
    
//    MARK: - private func
    private func commonInit() {
        title = "Папки"
        
        setSettingsButton()
        tabBarController?.tabBar.items?[0].image = nil
        tabBarController?.tabBar.items?[0].title = nil
        
        view.addSubview(foldersView)
        NSLayoutConstraint.activate([
            foldersView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            foldersView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            foldersView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            foldersView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
    
//    MARK: - obj-c
    @objc private func addNewFolder(_ action: UIAlertAction) {
        if newFolderAlert.textFields?[0].text != Optional("") && newFolderAlert.textFields?[0].text != "" {
            let date = NSDate()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM"
            let time = formatter.string(from: date as Date)
            
            dataManager.saveFolder(name: newFolderAlert.textFields?[0].text ?? "", date: time)
            newFolderAlert.textFields?[0].text = nil
            foldersView.getTableData(dataManager.folders)
            dismiss(animated: true)
        } else {
            Vibration.error.vibrate()
            present(newFolderAlert, animated: true)
        }
    }
    
    @objc private func deleteAllFolders(_ action: UIAlertAction) {
        dataManager.deleteAllFolders()
        foldersView.getTableData(dataManager.folders)
    }

}

extension FoldersController: FoldersViewDelegate {
    func didSelectCell(_ indexPath: IndexPath) {
        let controller = NotesController()
        controller.configurate(dataManager.folders[indexPath.item])
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func updateCountLabel(_ count: Int) {
        countLabel.configurate(count)
    }
}

// MARK: - extension
extension FoldersController: ButtonDelegate {
    func didSelectButton(_ type: TypeButton) {
        switch type {
        case .trash:
            if dataManager.folders.count != 0 {
                present(deleteAllFoldersAlert, animated: true)
            }
        case .addFolder:
            present(newFolderAlert, animated: true)
        default: break
        }
    }
}

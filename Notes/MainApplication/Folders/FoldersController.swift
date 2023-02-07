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
    
//    MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        foldersView.getTableData(dataManager.folders)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let addNewFolderButton = Button(frame: CGRect(x: view.frame.width - 80, y: 0, width: 80, height: 48), type: .addFolder)
        addNewFolderButton.delegate = self
        tabBarController?.tabBar.addSubview(addNewFolderButton)
    }
    
//    MARK: - private func
    private func commonInit() {
        title = "Папки"
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"), style: .done, target: self, action: #selector(tapSettingsButton))
        navigationItem.rightBarButtonItem = settingsButton
        tabBarController?.tabBar.items?[0].image = nil
        tabBarController?.tabBar.items?[0].title = nil
        
        let trashButton = Button(frame: CGRect(x: 0, y: 0, width: 80, height: 48), type: .trash)
        trashButton.delegate = self
        tabBarController?.tabBar.addSubview(trashButton)
        
        view.addSubview(foldersView)
        foldersView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            foldersView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            foldersView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            foldersView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            foldersView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
    
//    MARK: - obj-c
    @objc private func tapSettingsButton() {
        
    }
    
    @objc private func addNewFolder(_ action: UIAlertAction) {
        if newFolderAlert.textFields?[0].text != Optional("") && newFolderAlert.textFields?[0].text != "" {
            dataManager.saveFolder(name: newFolderAlert.textFields?[0].text ?? "", date: "hxuihu")
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
    func didSelectCell() {
//        <#code#>
    }
}

extension FoldersController: ButtonDelegate {
    func didSelectButton(_ type: TypeButton) {
        switch type {
        case .trash:
            if dataManager.folders.count != 0 {
                present(deleteAllFoldersAlert, animated: true)
            }
        case .addFolder:
            present(newFolderAlert, animated: true)
        }
    }
}

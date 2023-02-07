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
    
    private lazy var alert: UIAlertController = {
        let alert = UIAlertController(title: "Создать новую папку", message: "Напишите название новой папки", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Создать", style: .default, handler: addNewFolder))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alert.addTextField()
        
        return alert
    }()
    
//    MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        foldersView.getTableData(dataManager.folders)
    }
    
//    MARK: - private func
    private func commonInit() {
        title = "Папки"
//        let addFolderButton = UIBarButtonItem(image: UIImage(systemName: "folder.fill.badge.plus"), style: .done, target: self, action: #selector(tapNewFolderButton))
//        let deleteAllFolderButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .done, target: self, action: #selector(tapDeleteAllFolderButton))
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"), style: .done, target: self, action: #selector(tapSettingsButton))
        navigationItem.rightBarButtonItem = settingsButton
        tabBarController?.tabBar.items?[0].image = nil
        tabBarController?.tabBar.items?[0].title = nil
        
        let trashButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 48))
//        trashButton.setImage(UIImage(systemName: "trash.fill"), for: .normal)
//        trashButton.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        trashButton.addTarget(self, action: #selector(tapDeleteAllFolderButton), for: .touchUpInside)
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
    @objc private func tapNewFolderButton() {
        present(alert, animated: true)
    }
    
    @objc private func tapDeleteAllFolderButton() {
        dataManager.deleteAllFolders()
        foldersView.getTableData(dataManager.folders)
    }
    
    @objc private func tapSettingsButton() {
        
    }
    
    @objc private func addNewFolder(_ action: UIAlertAction) {
        if alert.textFields?[0].text != Optional("") && alert.textFields?[0].text != "" {
            dataManager.saveFolder(name: alert.textFields?[0].text ?? "", date: "hxuihu")
            alert.textFields?[0].text = nil
            foldersView.getTableData(dataManager.folders)
            dismiss(animated: true)
        } else {
            Vibration.error.vibrate()
            present(alert, animated: true)
        }
    }

}

extension FoldersController: FoldersViewDelegate {
    func didSelectCell() {
//        <#code#>
    }
}

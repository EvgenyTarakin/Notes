//
//  FoldersView.swift
//  Notes
//
//  Created by Евгений Таракин on 06.02.2023.
//

import UIKit

// MARK: - protocol
protocol FoldersViewDelegate: AnyObject {
    func didSelectCell()
}

class FoldersView: UIView {
    
//    MARK: - property
    weak var delegate: FoldersViewDelegate?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = false
        tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tableView.register(FolderCell.self, forCellReuseIdentifier: FolderCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private lazy var dataSource = DataSource(tableView: tableView, cellProvider: { (tableView, indexPath, item) -> UITableViewCell? in
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FolderCell.reuseIdentifier, for: indexPath) as? FolderCell else { return UITableViewCell() }
        cell.configurate(folder: item, fontSize: Settings().size as! CGFloat, fontType: Settings().type as! UIFont.Weight)
        
        return cell
    })
    
//    MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//    MARK: - private func
    private func commonInit() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
//    MARK: - func
    func getTableData(_ data: [Folder]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Folder>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data, toSection: .main)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func updateFont() {
        tableView.reloadData()
    }

}

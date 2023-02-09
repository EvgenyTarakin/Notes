//
//  FoldersView.swift
//  Notes
//
//  Created by Евгений Таракин on 06.02.2023.
//

import UIKit

// MARK: - protocol
protocol FoldersViewDelegate: AnyObject {
    func didSelectCell(_ indexPath: IndexPath)
}

class FoldersView: UIView {
    
//    MARK: - property
    var delegate: FoldersViewDelegate?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
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

extension FoldersView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectCell(indexPath)
    }
}

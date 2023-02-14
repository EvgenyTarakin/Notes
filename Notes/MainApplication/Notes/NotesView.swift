//
//  NotesView.swift
//  Notes
//
//  Created by Евгений Таракин on 09.02.2023.
//

import UIKit

class NotesView: UIView {
    
//    MARK: - property
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = false
        tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private lazy var dataSource = NotesDataSource(tableView: tableView, cellProvider: { (tableView, indexPath, item) -> UITableViewCell? in
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.reuseIdentifier, for: indexPath) as? NoteCell else { return UITableViewCell() }
//        cell.configurate(folder: item, fontSize: Settings().size as! CGFloat, fontType: Settings().type as! UIFont.Weight)
        
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
        
    }

}

extension NotesView: UITableViewDelegate {
    
}

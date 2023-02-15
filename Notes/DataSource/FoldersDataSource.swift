//
//  DataSource.swift
//  Notes
//
//  Created by Евгений Таракин on 06.02.2023.
//

import UIKit

final class FoldersDataSource: UITableViewDiffableDataSource<Section, Folder> {
    
    private var dataManager = DataManager()
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var snapshot = self.snapshot()
            if let item = itemIdentifier(for: indexPath) {
                snapshot.deleteItems([item])
                dataManager.deleteFolder(item)
                apply(snapshot, animatingDifferences: true)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard let sourceItem = itemIdentifier(for: sourceIndexPath) else { return }
        
        guard sourceIndexPath != destinationIndexPath else {
            print("move to self")
            return
        }
        
        let destinationItem = itemIdentifier(for: destinationIndexPath)
        
        var snapshot = self.snapshot()
        
        if let destinationItem = destinationItem {
            
            if let sourceIndex = snapshot.indexOfItem(sourceItem),
               let destinationIndex = snapshot.indexOfItem(destinationItem) {
                let isAfter = destinationIndex > sourceIndex
                && snapshot.sectionIdentifier(containingItem: sourceItem) ==
                snapshot.sectionIdentifier(containingItem: destinationItem)
                snapshot.deleteItems([sourceItem])
                if isAfter {
                    print("after destination")
                    snapshot.insertItems([sourceItem], afterItem: destinationItem)
                } else {
                    print("before destination")
                    snapshot.insertItems([sourceItem], beforeItem: destinationItem)
                }
            }
            
        } else {
            print("new index path")
            let destinationSection = snapshot.sectionIdentifiers[destinationIndexPath.section]
            snapshot.deleteItems([sourceItem])
            snapshot.appendItems([sourceItem], toSection: destinationSection)
        }
        apply(snapshot, animatingDifferences: false)
    }
    
}

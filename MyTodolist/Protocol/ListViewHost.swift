//
//  ListViewHost.swift
//  MyTodolist
//
//  Created by 謝宛軒 on 2020/10/15.
//  Copyright © 2020 謝宛軒. All rights reserved.
//

import Foundation
import UIKit

//負責收到從Controller送出的insert index array告訴ViewController
protocol ListViewHostProtocol: AnyObject {
    func insert(at indices: [Int])
}

extension ListViewHostProtocol{
    func insert(at indices: [Int]){
    }
}

//extension ListViewHostProtocol where Self: UITableViewController{
//    func insert(at indices: [Int]) {
//        let indexPaths = indices.map { IndexPath(row: $0, section: 0) }
//        let contentOffset = tableView.contentOffset
//        tableView.beginUpdates()
//        tableView.insertRows(at: indexPaths, with: .fade)
//        tableView.endUpdates()
//        tableView.setContentOffset(contentOffset, animated: false)
//    }
//}
//
//extension ListViewHostProtocol where Self: UICollectionViewController{
//    func insert(at indices: [Int]) {
//        let indexPaths = indices.map { IndexPath(row: $0, section: 0) }
//        collectionView.performBatchUpdates({ [weak self] in
//            self?.collectionView.insertItems(at: indexPaths)
//            }, completion: nil)
//    }
//}


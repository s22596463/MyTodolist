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
    //func delete(at indices: [Int])
}

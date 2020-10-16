//
//  Todolist+CoreDataProperties.swift
//  MyTodolist
//
//  Created by 謝宛軒 on 2020/10/16.
//  Copyright © 2020 謝宛軒. All rights reserved.
//
//

import Foundation
import CoreData


extension Todolist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todolist> {
        return NSFetchRequest<Todolist>(entityName: "Todolist")
    }

    @NSManaged public var isPinned: Bool
    @NSManaged public var title: String?

}

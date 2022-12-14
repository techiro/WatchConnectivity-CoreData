//
//  Memo+CoreDataProperties.swift
//  Watch_SaveTask
//
//  Created by TanakaHirokazu on 2022/09/27.
//
//

import Foundation
import CoreData


extension Memo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Memo> {
        return NSFetchRequest<Memo>(entityName: "Memo")
    }

    @NSManaged public var dateAdded: Date?
    @NSManaged public var title: String?
    @NSManaged public var uuid: String?
}

extension Memo : Identifiable {
}

extension Memo {
    
}

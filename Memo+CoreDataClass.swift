//
//  Memo+CoreDataClass.swift
//  Watch_SaveTask
//
//  Created by TanakaHirokazu on 2022/09/27.
//
//

import Foundation
import CoreData

@objc(Memo)
public class Memo: NSManagedObject, Decodable, Encodable {
    enum CodingKeys: CodingKey {
        case title, dateAdded, uuid
    }

    required public convenience init(from decoder: Decoder) throws {

        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else { fatalError() }

        self.init(context: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.dateAdded = try container.decode(Date.self, forKey: .dateAdded)
        self.uuid = try container.decode(String.self, forKey: .uuid)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(dateAdded, forKey: .dateAdded)
        try container.encode(uuid, forKey: .uuid)
    }

    static func == (lhs: Memo, rhs: Memo) -> Bool {
        return lhs.uuid == rhs.uuid
    }

}

extension CodingUserInfoKey {
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

//
//  Model.swift
//  MobileProject-MVVM
//
//  Created by Pankaj Gaikar on 30/06/20.
//  Copyright © 2020 Pankaj Gaikar. All rights reserved.
//

import Foundation
import RealmSwift

class DataModel: Object, Decodable {
    @objc dynamic var ID: String
    @objc dynamic var type: String
    @objc dynamic var date: String?
    @objc dynamic var data: String?
    
    enum CodingKeys: String, CodingKey {
        case ID = "id"
        case type, date, data
    }
    
    override class func primaryKey() -> String? {
        return "ID"
    }
    
}

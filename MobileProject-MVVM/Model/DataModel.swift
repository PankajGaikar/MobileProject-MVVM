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
    @objc let ID: String
    @objc let type: String
    @objc let date: String?
    @objc let data: String?
    
    enum CodingKeys: String, CodingKey {
        case ID = "id"
        case type, date, data
    }
    
}

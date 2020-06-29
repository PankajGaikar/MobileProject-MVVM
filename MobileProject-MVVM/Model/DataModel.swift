//
//  Model.swift
//  MobileProject-MVVM
//
//  Created by Pankaj Gaikar on 30/06/20.
//  Copyright © 2020 Pankaj Gaikar. All rights reserved.
//

import Foundation

struct DataModel: Decodable {
    let ID: String
    let type: String
    let date: String?
    let data: String?
    
    enum CodingKeys: String, CodingKey {
        case ID = "id"
        case type, date, data
    }

}

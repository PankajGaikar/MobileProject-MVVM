//
//  RealmManager.swift
//  MobileProject-MVVM
//
//  Created by MMT on 30/06/20.
//  Copyright © 2020 Pankaj Gaikar. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    
    func storeDataToRealm(models: [DataModel]) -> Void {
        let realm = try! Realm()
        try! realm.write {
            realm.add(models)
        }
    }
    
    func getDataFromRealm() -> [DataModel] {
        let realm = try! Realm()
        let results = try! realm.objects(DataModel.self)
        return Array(results)
    }
    
}

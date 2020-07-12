//
//  DataViewModel.swift
//  MobileProject-MVVM
//
//  Created by Pankaj Gaikar on 30/06/20.
//  Copyright © 2020 Pankaj Gaikar. All rights reserved.
//

import Foundation

/*
 * This protocol will be utilised to inform View classes regarding network activities,
 * such as success in data retrieval and failures
 */
protocol DataViewModelDelegate {
    func dataRefreshSuccess()
    func dataFetchError(error: DataError)
}

class DataViewModel {
    
    //Data updation protocol instance
    var dataViewModelDelegate: DataViewModelDelegate?
    
    // This will be change as soon as user selects different segment.
    public var currentFilter = 0 {
        didSet {
            setFilteredData()
        }
    }
    
    //Datasource
    var dataList = [DataModel]()
    
    //Private array to import from database/API
    private var persistantDataList = [DataModel]() {
        didSet {
            setFilteredData()
        }
    }
    
    //MARK: API call
    public func getDataList() -> Void {
                
        APIservice().getData { (result) in
            
            switch result {
                
            case .failure(let error):
                print(error.localizedDescription)
                self.dataViewModelDelegate?.dataFetchError(error: error)
                
            case .success(let dataList):
                //TODO: Save data in Realm
                self.persistantDataList = dataList
                self.dataViewModelDelegate?.dataRefreshSuccess()
                DispatchQueue.main.async {
                    RealmManager().storeDataToRealm(models: dataList)
                }
            }
        }
    }
    
    public func retrieveOfflineDataIfAvailable() -> Void {
        persistantDataList = RealmManager().getDataFromRealm()
        self.dataViewModelDelegate?.dataRefreshSuccess()
    }
    
    // Helper method
    fileprivate func setFilteredData() {
        switch currentFilter {
        case 1:
            self.dataList = persistantDataList.filter( { $0.type == "image" } )
            
        case 2:
            self.dataList = persistantDataList.filter( { $0.type == "text" } )
            
        case 3:
            self.dataList = persistantDataList.filter( { $0.type == "other" } )
            
        default:
            self.dataList = persistantDataList
        }
        
        self.dataViewModelDelegate?.dataRefreshSuccess()
    }
    
}

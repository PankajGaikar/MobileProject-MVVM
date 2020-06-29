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
    func dataFetchSuccess()
    func dataFetchError(error: DataError)
}

class DataViewModel {
    
    //Data updation protocol instance
    var dataViewModelDelegate: DataViewModelDelegate?
    
    // This will be change as soon as user selects different segment.
    public var currentFilter = 0 {
        didSet {
            print("Changed filter value to \(currentFilter)")
        }
    }
    
    //Datasource
    var dataList = [DataModel]()
    
    //MARK: API call
    public func getDataList() -> Void {
        
        APIservice().getData { (result) in
            
            switch result {
                
                case .failure(let error):
                    print(error.localizedDescription)
                    self.dataViewModelDelegate?.dataFetchError(error: error)
                    
                case .success(let dataList):
                    //TODO: Save data in Realm
                    self.dataList = dataList
                    self.dataViewModelDelegate?.dataFetchSuccess()
            }
        }
    }
    
}

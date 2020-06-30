//
//  ViewController.swift
//  MobileProject-MVVM
//
//  Created by Pankaj Gaikar on 30/06/20.
//  Copyright © 2020 Pankaj Gaikar. All rights reserved.
//

import UIKit
import SnapKit

class RootViewController: UIViewController, ConstraintRelatableTarget {

    private var tableView: UITableView!
    private var segmentedControl: UISegmentedControl!
    
    let dataViewModel = DataViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        
        // With this property, we set which sides of your view can be extended to cover the whole screen.
        // When the view of that view controller is laid out, it will start where the navigation bar ends
        self.edgesForExtendedLayout = []
        
        //Setup tableview
        setupTableView()
        
        //Setup segmented control
        setupSegmentedControl()
        
        //Setup Constraints
        layoutSubViews()
        
        //Fetch Data
        dataViewModel.dataViewModelDelegate = self
        dataViewModel.getDataList()
    }
    
    //MARK: Setup Views
    fileprivate func setupSegmentedControl() -> Void {
        segmentedControl = UISegmentedControl(items: Constants.segmentedControlMenu )
        self.view.addSubview(segmentedControl)
        segmentedControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
    }
    
    fileprivate func setupTableView() -> Void {
        tableView = UITableView()
        self.view.addSubview(tableView)
        tableView.register(DataTableViewCell.self, forCellReuseIdentifier: Constants.ReusableCellIdentifier)
        tableView.register(ImageDataTableViewCell.self, forCellReuseIdentifier: Constants.ReusableImageCellIdentifier)
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    /*
     * This API creates a View Layout for Data List screen.
     */
    fileprivate func layoutSubViews() -> Void {
        segmentedControl.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }

        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(segmentedControl.snp.bottom)
        }
    }
    
    //MARK: Segmented Control Actions
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!) {
        dataViewModel.currentFilter = sender.selectedSegmentIndex
    }

}

//MARK: TableView Delegate and Datasource
extension RootViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if dataViewModel.currentFilter == 0 {
            return 3
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataViewModel.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataModel =  dataViewModel.dataList[indexPath.row]
        if dataModel.type == "text" ||
            dataModel.type == "other" {
            return createDataTableViewCell(tableView, indexPath, dataModel)
        }
        else {
            return createImageTableViewCell(tableView, indexPath, dataModel)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    /*
     * This function creates instance of Data Cell and returns it.
     */
    fileprivate func createDataTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath, _ dataModel: DataModel) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ReusableCellIdentifier, for: indexPath) as! DataTableViewCell
        cell.dataModel = dataModel
        cell.contentView.updateConstraints()
        return cell
    }
    
    /*
     * This function creates instance of image cell and returns.
     */
    fileprivate func createImageTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath, _ dataModel: DataModel) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ReusableImageCellIdentifier, for: indexPath) as! ImageDataTableViewCell
        cell.dataModel = dataModel
        cell.contentView.updateConstraints()
        return cell
    }
}

//MARK: DataViewModel extension
extension RootViewController: DataViewModelDelegate {
    func dataFetchSuccess() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func dataFetchError(error: DataError) {
        let alertController = UIAlertController(title: "Error Occurred", message: "Ah uhhh, Something went wrong", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

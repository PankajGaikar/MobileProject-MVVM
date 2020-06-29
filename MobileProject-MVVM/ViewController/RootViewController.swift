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
    }
    
    //MARK: Setup Views
    fileprivate func setupSegmentedControl() -> Void {
        segmentedControl = UISegmentedControl(items: ["All", "Image", "Text", "Other"] )
        self.view.addSubview(segmentedControl)
        segmentedControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
    }
    
    fileprivate func setupTableView() -> Void {
        tableView = UITableView()
        self.view.addSubview(tableView)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100.0
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
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
    }


}


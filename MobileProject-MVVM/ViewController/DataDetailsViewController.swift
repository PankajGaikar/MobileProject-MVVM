//
//  DataDetailsViewController.swift
//  MobileProject-MVVM
//
//  Created by Pankaj Gaikar on 30/06/20.
//  Copyright © 2020 Pankaj Gaikar. All rights reserved.
//

import UIKit

class DataDetailsViewController: UIViewController {

    let scrollView = UIScrollView()
    let containerView = UIView()
    let dataLabel = UILabel()
    let dateLabel = UILabel()

    var dataModel: DataModel
    
    init(model: DataModel) {
        self.dataModel = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Data Details View"
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(dataLabel)
        containerView.addSubview(dateLabel)

        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        containerView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(scrollView)
            make.left.right.equalTo(self.view.safeAreaLayoutGuide)
            make.width.equalTo(scrollView)
            make.height.equalTo(scrollView).priorityLow()
            make.bottom.equalTo(scrollView.snp.bottom)
        }
        setAdditionalConstraints()
    }
    
    func setAdditionalConstraints() {
    
        dataLabel.numberOfLines = 0;
        dataLabel.text = dataModel.data
        dateLabel.text = dataModel.date

        dataLabel.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.bottom.equalToSuperview().offset(-20)
            make.top.equalTo(dataLabel.snp.bottom).offset(10)
        }
    }
}

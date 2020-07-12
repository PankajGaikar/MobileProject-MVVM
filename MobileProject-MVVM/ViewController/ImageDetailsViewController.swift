//
//  ImageDetailsViewController.swift
//  MobileProject-MVVM
//
//  Created by MMT on 30/06/20.
//  Copyright © 2020 Pankaj Gaikar. All rights reserved.
//

import UIKit

class ImageDetailsViewController: UIViewController {

    //View elements
    let scrollView = UIScrollView()
    let containerView = UIView()
    let imageView = UIImageView()
    let dateLabel = UILabel()

    //Model
    var dataModel: DataModel
    
    //Init
    init(model: DataModel) {
        self.dataModel = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        //Basic view setup
        self.view.backgroundColor = .white
        self.title = "Data Details View"
        
        setupViews()
        setupConstraints()
    }
    
    fileprivate func setupViews() {
        //Add all view elements in hierarchy
        self.view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(dateLabel)
        
        imageView.loadImage(url: dataModel.data ?? "", placeholder: UIImage(named: UIConstants.PlaceholderImage))
        
        //Change font for date label.
        dateLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        dateLabel.text = dataModel.date
    }

    fileprivate func setupConstraints() {
    
        //Add scrollview constraints, pin all edges to safe area
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        //Add Container constraints.
        //Low priority to height. It has to be flexible depending on views inside the container.
        containerView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(scrollView)
            make.left.right.equalTo(self.view.safeAreaLayoutGuide)
            make.width.equalTo(scrollView)
            make.height.equalTo(scrollView).priorityLow()
            make.bottom.equalTo(scrollView.snp.bottom)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(200)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-20)
        }
    }

}

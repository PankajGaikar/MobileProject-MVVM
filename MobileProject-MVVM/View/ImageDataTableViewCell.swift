//
//  ImageDataTableViewCell.swift
//  MobileProject-MVVM
//
//  Created by Pankaj Gaikar on 12/07/20.
//  Copyright © 2020 Pankaj Gaikar. All rights reserved.
//

import UIKit

class ImageDataTableViewCell: UITableViewCell {
    
    let iconImageView = UIImageView()
    let dateLabel = UILabel()
    let idLabel = UILabel()
    let typeLabel = UILabel()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.autoresizingMask = .flexibleHeight
        addViewElementsInContentView()
        setupLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    /*
     * Custom implementation
     */
    
    //Add view elements to ContentView
    fileprivate func addViewElementsInContentView() {
        self.contentView.addSubview(iconImageView)
        self.contentView.addSubview(idLabel)
        self.contentView.addSubview(typeLabel)
        self.contentView.addSubview(dateLabel)
    }
    
    //Set data from models to view elements
    fileprivate func setDataForViewElements() {
        idLabel.text = dataModel?.ID
        typeLabel.text = dataModel?.type
        dateLabel.text = dataModel?.date
        dateLabel.numberOfLines = 0
        
        /*
         * Use extension to fetch data.
         * Extension also cache the data and sets placeholder image.
         */
        iconImageView.loadImage(url: dataModel?.data ?? "", placeholder: UIImage(named: UIConstants.PlaceholderImage))
    }
    
    var dataModel: DataModel? {
        didSet {
            //Once model is assigned, lay all data on elements.
            setDataForViewElements()
        }
    }
    
    fileprivate func setupLayoutConstraints() {
        
        /*
         * Center image
         * Place from left
         * 100*100
         */
        iconImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.leading.equalToSuperview().offset(15)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        /*
         * Align all labels vertically one after another.
         */
        idLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.leading.equalTo(iconImageView.snp.trailing).offset(15)
            make.trailing.equalToSuperview()
        }
        
        typeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(idLabel.snp.bottom).offset(15)
            make.leading.equalTo(iconImageView.snp.trailing).offset(15)
            make.trailing.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(typeLabel.snp.bottom).offset(10)
            make.leading.equalTo(iconImageView.snp.trailing).offset(15)
            make.trailing.equalToSuperview().offset(15)
        }
        
        self.contentView.updateConstraints()
    }

    
}

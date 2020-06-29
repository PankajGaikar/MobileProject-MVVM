//
//  DataTableViewCell.swift
//  MobileProject-MVVM
//
//  Created by Pankaj Gaikar on 30/06/20.
//  Copyright © 2020 Pankaj Gaikar. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {

    let iconImageView = UIImageView()
    let dataLabel = UILabel()
    let dateLabel = UILabel()
    let idLabel = UILabel()
    let typeLabel = UILabel()

    fileprivate func addViewElementsInContentView() {
        self.contentView.addSubview(idLabel)
        self.contentView.addSubview(typeLabel)
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(iconImageView)
        self.contentView.addSubview(dataLabel)
    }
    
    fileprivate func setDataForViewElements() {
        idLabel.text = dataModel?.ID
        typeLabel.text = dataModel?.type
        dateLabel.text = dataModel?.date
        dataLabel.text = dataModel?.data
        dateLabel.numberOfLines = 0
        iconImageView.image = UIImage(named: "placeholder.png")
    }
    
    var dataModel: DataModel? {
        didSet {
            for subview in self.contentView.subviews {
                subview.removeFromSuperview()
            }
            
            addViewElementsInContentView()
            setDataForViewElements()
            
            idLabel.snp.makeConstraints { (make) in
                make.leading.top.equalToSuperview().offset(15)
                make.height.equalTo(21)
            }
            
            typeLabel.snp.makeConstraints { (make) in
                make.trailing.top.equalToSuperview().offset(15)
                make.leading.equalTo(idLabel.snp.trailing).offset(10)
                make.width.equalTo(idLabel.snp.width)
                make.height.equalTo(idLabel.snp.height)
            }
            
            dateLabel.snp.makeConstraints { (make) in
                make.leading.trailing.equalToSuperview().offset(15)
                make.top.equalTo(idLabel.snp.bottom).offset(10)
                if dataModel?.date?.count ?? 0 > 0 {
//                    make.height.equalTo(21)
                }
                else
                {
                    make.height.equalTo(0)
                }
            }
            
            if dataModel?.type == "image" {
                
                iconImageView.snp.makeConstraints { (make) in
                    make.top.equalTo(dateLabel.snp.bottom).offset(10)
                    make.width.equalTo(100)
                    make.centerX.equalTo(self.contentView)
                    make.bottom.equalToSuperview().offset(-15)
                    
                    if dataModel?.type == "image" {
                        make.height.equalTo(100)
                    }
                    else
                    {
                        make.height.equalTo(0)
                    }
                }
            }
            
            if dataModel?.type == "text" {
                dataLabel.numberOfLines = 0
                dataLabel.snp.makeConstraints { (make) in
                    make.top.equalTo(dateLabel.snp.bottom).offset(10)
                    make.leading.trailing.equalToSuperview().offset(15)
                    make.bottom.equalToSuperview().offset(-15)
                    make.height.greaterThanOrEqualTo(30)
                }
            }
            self.contentView.updateConstraints()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

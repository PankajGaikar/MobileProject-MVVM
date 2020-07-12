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

        fileprivate func addViewElementsInContentView() {
            self.contentView.addSubview(idLabel)
            self.contentView.addSubview(typeLabel)
            self.contentView.addSubview(dateLabel)
            self.contentView.addSubview(iconImageView)
        }
        
        fileprivate func setDataForViewElements() {
            idLabel.text = dataModel?.ID
            typeLabel.text = dataModel?.type
            dateLabel.text = dataModel?.date
            dateLabel.numberOfLines = 0
            iconImageView.image = UIImage(named: UIConstants.PlaceholderImage )
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
                }
                
                iconImageView.snp.makeConstraints { (make) in
                    make.top.equalTo(dateLabel.snp.bottom)
                    make.width.equalTo(100)
                    make.height.equalTo(100).priorityLow()
                    make.centerX.equalTo(self.contentView)
                    make.bottom.equalToSuperview().offset(-15)
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

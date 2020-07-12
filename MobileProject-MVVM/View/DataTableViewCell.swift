//
//  DataTableViewCell.swift
//  MobileProject-MVVM
//
//  Created by Pankaj Gaikar on 30/06/20.
//  Copyright © 2020 Pankaj Gaikar. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {

    let dataLabel = UILabel()
    let dateLabel = UILabel()
    let idLabel = UILabel()
    let typeLabel = UILabel()

    var dataModel: DataModel? {
        didSet {
            setDataForViewElements()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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

    fileprivate func addViewElementsInContentView() {
        self.contentView.addSubview(idLabel)
        self.contentView.addSubview(typeLabel)
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(dataLabel)
    }
    
    //Adds view element to content view.
    fileprivate func setDataForViewElements() {
        idLabel.font = UIFont.preferredFont(forTextStyle: .callout)
        typeLabel.font = UIFont.preferredFont(forTextStyle: .callout)
        dateLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        dataLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        
        idLabel.text = dataModel?.ID
        typeLabel.text = dataModel?.type
        dateLabel.text = dataModel?.date
        dataLabel.text = dataModel?.data
        dateLabel.numberOfLines = 5
    }
    
    fileprivate func setupLayoutConstraints() {
        /*
         * Keep id and type side by side
         * Place date below it
         * Show text/other data below it.
         */
        idLabel.snp.makeConstraints { (make) in
            make.topMargin.equalToSuperview().offset(10)
            make.leadingMargin.equalToSuperview()
        }
        
        typeLabel.snp.makeConstraints { (make) in
            make.trailingMargin.top.equalToSuperview().offset(15)
            make.leadingMargin.equalTo(idLabel.snp.trailing).offset(10)
            make.width.equalTo(idLabel.snp.width)
            make.height.equalTo(idLabel.snp.height)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.leadingMargin.trailingMargin.equalToSuperview()
            make.top.equalTo(idLabel.snp.bottom).offset(10)
        }
        
        dataLabel.numberOfLines = 5
        dataLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dateLabel.snp.bottom).offset(10).priorityLow()
            make.leadingMargin.trailingMargin.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
        }
        
        self.contentView.updateConstraints()
    }

}

//
//  CMBillTableViewCell.swift
//  CommonMoney
//
//  Created by Dominika Czarnecka on 23.11.2016.
//  Copyright © 2016 dominika.czarnecka. All rights reserved.
//

import UIKit

class CMBillTableViewCell: UITableViewCell {

    let whiteView = UIView.init()
    let ownerAndDateLabel = UILabel()
    let ownerImage = UIImageView()
    let titleLabel = UILabel()
    
    let separatorView = UIView()
    let priceLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        
        self.addSubview(whiteView)
        whiteView.translatesAutoresizingMaskIntoConstraints = false
        whiteView.backgroundColor = UIColor.white
        whiteView.layer.cornerRadius = 10
        
        self.addSubview(ownerAndDateLabel)
        ownerAndDateLabel.translatesAutoresizingMaskIntoConstraints = false
        ownerAndDateLabel.textColor = UIColor.gray
        ownerAndDateLabel.font = UIFont.appFont(bold: false, fontSize: 10)
        ownerAndDateLabel.adjustsFontSizeToFitWidth = true
        
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.appFont(bold: false, fontSize: 14)
        titleLabel.adjustsFontSizeToFitWidth = true
        
        self.addSubview(ownerImage)
        ownerImage.translatesAutoresizingMaskIntoConstraints = false
        ownerImage.contentMode = .scaleAspectFit
        ownerImage.clipsToBounds = true
        ownerImage.layer.masksToBounds = true
        
        self.addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.textAlignment = .center
        priceLabel.font = titleLabel.font
        priceLabel.adjustsFontSizeToFitWidth = true
        
        setupConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {

            self.whiteView.backgroundColor = highlighted ? UIColor.clear : UIColor.white
    }
    
    func setupConstraints(){
        
        self.addConstraints(
            [NSLayoutConstraint.init(item: whiteView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: whiteView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: -3),
            NSLayoutConstraint.init(item: whiteView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1.0, constant: -10),
            NSLayoutConstraint.init(item: whiteView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: -10)])
        
        self.addConstraints([
            NSLayoutConstraint.init(item: ownerImage, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 5),
            NSLayoutConstraint.init(item: ownerImage, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 8),
            NSLayoutConstraint.init(item: ownerImage, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1.0, constant: -15),
            NSLayoutConstraint.init(item: ownerImage, attribute: .width, relatedBy: .equal, toItem: ownerImage, attribute: .height, multiplier: 1.0, constant: -15)])
        
        self.addConstraints([
            NSLayoutConstraint.init(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 5),
            NSLayoutConstraint.init(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: ownerImage, attribute: .right, multiplier: 1.0, constant: 5),
            NSLayoutConstraint.init(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 15),
            NSLayoutConstraint.init(item: titleLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.5, constant: 0)])
        
        self.addConstraints([
            NSLayoutConstraint.init(item: ownerAndDateLabel, attribute: .bottom, relatedBy: .equal, toItem: titleLabel, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: ownerAndDateLabel, attribute: .left, relatedBy: .equal, toItem: ownerImage, attribute: .right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: ownerAndDateLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 15),
            NSLayoutConstraint.init(item: ownerAndDateLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.5, constant: 0)])
        
        self.addConstraints([
            NSLayoutConstraint.init(item: priceLabel, attribute: .centerY, relatedBy: .equal, toItem: titleLabel, attribute: .centerY, multiplier: 1.0, constant: -5),
            NSLayoutConstraint.init(item: priceLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: -5),
            NSLayoutConstraint.init(item: priceLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 15),
            NSLayoutConstraint.init(item: priceLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.15, constant: 0)])
        
        self.addConstraints([
            NSLayoutConstraint.init(item: separatorView, attribute: .centerY, relatedBy: .equal, toItem: titleLabel, attribute: .centerY, multiplier: 1.0, constant: -5),
            NSLayoutConstraint.init(item: separatorView, attribute: .right, relatedBy: .equal, toItem: priceLabel, attribute: .left, multiplier: 1.0, constant: -5),
            NSLayoutConstraint.init(item: separatorView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.7, constant: 0),
            NSLayoutConstraint.init(item: separatorView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 0.2, constant: 1)])
    }


}

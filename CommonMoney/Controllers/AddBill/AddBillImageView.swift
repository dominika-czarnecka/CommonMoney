//
//  AddBillImageView.swift
//  CommonMoney
//
//  Created by Dominika Czarnecka on 30.12.2016.
//  Copyright © 2016 dominika.czarnecka. All rights reserved.
//

import UIKit

class AddBillImageView: UIView {

    let titleLabel = UILabel()
    let separatorView = UIView()
    let imageButton = UIButton.init()
    var billImage = UIImageView()
    
    init() {
       
        super.init(frame: CGRect.zero)
        
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 15
        
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.appFont(bold: false, fontSize: 12)
        titleLabel.textColor = Colors.buttonBlue
        titleLabel.text = "Bill"
        
        self.addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = Colors.buttonBlue
        
        self.addSubview(imageButton)
        imageButton.translatesAutoresizingMaskIntoConstraints = false
        imageButton.setImage(#imageLiteral(resourceName: "add"), for: .normal)
        imageButton.tintColor = Colors.buttonBlue
        
        self.addSubview(billImage)
        billImage.contentMode = .scaleAspectFit
        billImage.clipsToBounds = true
        
        setupConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints(){
        
        self.addConstraints(
            [NSLayoutConstraint.init(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0),
             NSLayoutConstraint.init(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 20),
             NSLayoutConstraint.init(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 10),
             NSLayoutConstraint.init(item: titleLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.8, constant: 0)
             ])
        
        self.addConstraints(
            [NSLayoutConstraint.init(item: separatorView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0),
             NSLayoutConstraint.init(item: separatorView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1.0, constant: 5),
             NSLayoutConstraint.init(item: separatorView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 1),
             NSLayoutConstraint.init(item: separatorView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.8, constant: 0)
            ])
        
        self.addConstraints(
            [NSLayoutConstraint.init(item: imageButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0),
             NSLayoutConstraint.init(item: imageButton, attribute: .top, relatedBy: .equal, toItem: separatorView, attribute: .bottom, multiplier: 1.0, constant: 5),
             NSLayoutConstraint.init(item: imageButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 30),
             NSLayoutConstraint.init(item: imageButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 30)
            ])
        
        self.addConstraints(
            [NSLayoutConstraint.init(item: billImage, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0),
             NSLayoutConstraint.init(item: billImage, attribute: .top, relatedBy: .equal, toItem: imageButton, attribute: .bottom, multiplier: 1.0, constant: 5),
             NSLayoutConstraint.init(item: billImage, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -30),
             NSLayoutConstraint.init(item: billImage, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.9, constant: 0)
            ])
    }
    
}
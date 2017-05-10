//
//  CMTextField.swift
//  CommonMoney
//
//  Created by Dominika Czarnecka on 23.11.2016.
//  Copyright © 2016 dominika.czarnecka. All rights reserved.
//

import UIKit

class CMTextField: UIView, UITextFieldDelegate{
    
    let titleLabel = UITextField()
    
    let separatorView = UIView()
    let typeLabel = UILabel()
    
    let pickerView = UIPickerView()
    let dataPickerView = UIDatePicker()
    
    init(type: String, dataPicker: Bool = false, picker: Bool = false) {
        super.init(frame: CGRect.zero)
        
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 10
        self.layer.cornerRadius = 10
        
        self.addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = Constants.Colors.lightGray
        
        self.addSubview(typeLabel)
        typeLabel.text = type
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.textAlignment = .center
        typeLabel.font =  UIFont.appFont(bold: false, fontSize: 12)
        typeLabel.adjustsFontSizeToFitWidth = true
        
        self.clipsToBounds = true

        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.appFont(bold: false, fontSize: 14)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.placeholder = type
        
        if dataPicker{
            dataPickerView.date = NSDate() as Date
            dataPickerView.maximumDate = NSDate() as Date
            dataPickerView.datePickerMode = .date
            dataPickerView.addTarget(self, action: #selector(dateDidChange), for: .valueChanged)
            titleLabel.inputView = dataPickerView
            titleLabel.delegate = self
        }
        
        if picker{
            titleLabel.inputView = pickerView
        }
        
        self.titleLabel.autocapitalizationType = UITextAutocapitalizationType.none
        self.titleLabel.autocorrectionType = .no
        self.titleLabel.textAlignment = .center
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isValid(withPattern pattern: String) -> Bool {
        do{
            let regEx = try NSRegularExpression.init(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let regExMaches = regEx.numberOfMatches(in: self.titleLabel.text!, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSRange.init(location: 0, length: self.titleLabel.text!.characters.count))
            if(regExMaches > 0){return true}
        }catch _{
            shake()
            return false
        }
        shake()
        return false
    }

    func shake(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        
        animation.fromValue = NSValue(cgPoint: CGPoint.init(x:self.center.x - 10, y:self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint.init(x:self.center.x + 10,y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    
    func dateDidChange(sender: UIDatePicker){
        
        let formater = DateFormatter()
        formater.dateFormat = "dd-MM-yyyy"
        
        titleLabel.text = formater.string(from: sender.date as Date)
        
    }
    
    func setupConstraints(){
        
        self.addConstraints([
            NSLayoutConstraint.init(item: typeLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: typeLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: typeLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 15),
            NSLayoutConstraint.init(item: typeLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.25, constant: 0)])
        
        self.addConstraints([
            NSLayoutConstraint.init(item: separatorView, attribute: .centerY, relatedBy: .equal, toItem: typeLabel, attribute: .centerY, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: separatorView, attribute: .left, relatedBy: .equal, toItem: typeLabel, attribute: .right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: separatorView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.7, constant: 0),
            NSLayoutConstraint.init(item: separatorView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 0.2, constant: 1)])
        
        self.addConstraints([
            NSLayoutConstraint.init(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 15),
            NSLayoutConstraint.init(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: separatorView, attribute: .right, multiplier: 1.0, constant: 0)])

    }
}

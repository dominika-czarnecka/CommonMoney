//
//  self.swift
//  CommonMoney
//
//  Created by Dominika Czarnecka on 06.01.2017.
//  Copyright © 2017 dominika.czarnecka. All rights reserved.
//

import UIKit

class RegisterView: UIView {

    let registerLabel = UILabel()
    let regLoginTextField = CMTextField(type: "Login")
    let regPasswordTextField = CMTextField(type: "Password")
    let regFirstNameTextField = CMTextField(type: "First name")
    let regLastNameTextField = CMTextField(type: "Last name")
    let regHomeTextField = CMTextField(type: "Home Id \n(opcional)")
    let regButton = CMButton()

    init(){
        super.init(frame: CGRect.zero)
        
        self.addSubview(registerLabel)
        registerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        registerLabel.textAlignment = .center
        registerLabel.numberOfLines = 0
        registerLabel.lineBreakMode = .byWordWrapping
        registerLabel.textColor = UIColor.white
        registerLabel.font = UIFont.appFont(bold: true, fontSize: 19)
        
        self.addSubview(regLoginTextField)
        regLoginTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(regPasswordTextField)
        regPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        regPasswordTextField.titleLabel.isSecureTextEntry = true
        
        self.addSubview(regFirstNameTextField)
        regFirstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(regLastNameTextField)
        regLastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(regHomeTextField)
        regHomeTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(regButton)
        regButton.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstreints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstreints(){
        //MARK: registerview const
        
        self.addConstraints([
            NSLayoutConstraint.init(item: regLastNameTextField, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: regLastNameTextField, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: regLastNameTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 40),
            NSLayoutConstraint.init(item: regLastNameTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: Constants.Size.CMTextFieldSize.width)])
        
        self.addConstraints([
            NSLayoutConstraint.init(item: regPasswordTextField, attribute: .centerX, relatedBy: .equal, toItem: self.regLastNameTextField, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: regPasswordTextField, attribute: .bottom, relatedBy: .equal, toItem: self.regLastNameTextField, attribute: .top, multiplier: 1.0, constant: -15),
            NSLayoutConstraint.init(item: regPasswordTextField, attribute: .height, relatedBy: .equal, toItem: self.regLastNameTextField, attribute: .height, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: regPasswordTextField, attribute: .width, relatedBy: .equal, toItem: self.regLastNameTextField, attribute: .width, multiplier: 1.0, constant: 0)])
        
        self.addConstraints([
            NSLayoutConstraint.init(item: regLoginTextField, attribute: .centerX, relatedBy: .equal, toItem: self.regLastNameTextField, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: regLoginTextField, attribute: .bottom, relatedBy: .equal, toItem: self.regPasswordTextField, attribute: .top, multiplier: 1.0, constant: -15),
            NSLayoutConstraint.init(item: regLoginTextField, attribute: .height, relatedBy: .equal, toItem: self.regLastNameTextField, attribute: .height, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: regLoginTextField, attribute: .width, relatedBy: .equal, toItem: self.regLastNameTextField, attribute: .width, multiplier: 1.0, constant: 0)])
        
        self.addConstraints([
            NSLayoutConstraint.init(item: registerLabel, attribute: .centerX, relatedBy: .equal, toItem: self.regLastNameTextField, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: registerLabel, attribute: .bottom, relatedBy: .equal, toItem: self.regLoginTextField, attribute: .top, multiplier: 1.0, constant: -15),
            NSLayoutConstraint.init(item: registerLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 100),
            NSLayoutConstraint.init(item: registerLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: Constants.Size.CMTextFieldSize.width)])
        
        self.addConstraints([
            NSLayoutConstraint.init(item: regFirstNameTextField, attribute: .centerX, relatedBy: .equal, toItem: self.regLastNameTextField, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: regFirstNameTextField, attribute: .top, relatedBy: .equal, toItem: self.regLastNameTextField, attribute: .bottom, multiplier: 1.0, constant: 15),
            NSLayoutConstraint.init(item: regFirstNameTextField, attribute: .height, relatedBy: .equal, toItem: self.regLastNameTextField, attribute: .height, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: regFirstNameTextField, attribute: .width, relatedBy: .equal, toItem: self.regLastNameTextField, attribute: .width, multiplier: 1.0, constant: 0)])
        
        self.addConstraints([
            NSLayoutConstraint.init(item: regHomeTextField, attribute: .centerX, relatedBy: .equal, toItem: self.regLastNameTextField, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: regHomeTextField, attribute: .top, relatedBy: .equal, toItem: self.regFirstNameTextField, attribute: .bottom, multiplier: 1.0, constant: 15),
            NSLayoutConstraint.init(item: regHomeTextField, attribute: .height, relatedBy: .equal, toItem: self.regLastNameTextField, attribute: .height, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: regHomeTextField, attribute: .width, relatedBy: .equal, toItem: self.regLastNameTextField, attribute: .width, multiplier: 1.0, constant: 0)])
        
        self.addConstraints([
            NSLayoutConstraint.init(item: regButton, attribute: .centerX, relatedBy: .equal, toItem: self.regLastNameTextField, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: regButton, attribute: .top, relatedBy: .equal, toItem: self.regHomeTextField, attribute: .bottom, multiplier: 1.0, constant: 15),
            NSLayoutConstraint.init(item: regButton, attribute: .height, relatedBy: .equal, toItem: self.regLastNameTextField, attribute: .height, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: regButton, attribute: .width, relatedBy: .equal, toItem: self.regLastNameTextField, attribute: .width, multiplier: 1.0, constant: 0)])
        
    }
    
}

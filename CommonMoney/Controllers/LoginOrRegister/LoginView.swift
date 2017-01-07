//
//  LoginView.swift
//  CommonMoney
//
//  Created by Dominika Czarnecka on 30.12.2016.
//  Copyright © 2016 dominika.czarnecka. All rights reserved.
//

import UIKit

class LoginView: UIView {

    let loginLabel = UILabel()
    let loginTextField = CMTextField(type:"Login")
    let passwordTextField = CMTextField(type: "Password")
    let loginButton = CMButton()

    init(){
        //TODO: Login with FB
        super.init(frame: CGRect.zero)
        
        self.backgroundColor = UIColor.clear
        
        self.addSubview(loginLabel)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.textAlignment = .center
        loginLabel.numberOfLines = 0
        loginLabel.lineBreakMode = .byWordWrapping
        loginLabel.textColor = UIColor.white
        loginLabel.font = UIFont.appFont(bold: true, fontSize: 20)
        
        self.addSubview(loginTextField)
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.titleLabel.isSecureTextEntry = true
        
        self.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
     
        setupConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints(){
        
        self.addConstraints([
            NSLayoutConstraint.init(item: passwordTextField, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: passwordTextField, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 50),
            NSLayoutConstraint.init(item: passwordTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: Size.CMTextFieldSize.height),
            NSLayoutConstraint.init(item: passwordTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: Size.CMTextFieldSize.width)])
        
        self.addConstraints([
            NSLayoutConstraint.init(item: loginTextField, attribute: .centerX, relatedBy: .equal, toItem: self.passwordTextField, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: loginTextField, attribute: .bottom, relatedBy: .equal, toItem: self.passwordTextField, attribute: .top, multiplier: 1.0, constant: -30),
            NSLayoutConstraint.init(item: loginTextField, attribute: .height, relatedBy: .equal, toItem: passwordTextField, attribute: .height, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: loginTextField, attribute: .width, relatedBy: .equal, toItem: passwordTextField, attribute: .width, multiplier: 1.0, constant: 0)])
        
        self.addConstraints([
            NSLayoutConstraint.init(item: loginButton, attribute: .centerX, relatedBy: .equal, toItem: self.passwordTextField, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: loginButton, attribute: .top, relatedBy: .equal, toItem: self.passwordTextField, attribute: .bottom, multiplier: 1.0, constant: 30),
            NSLayoutConstraint.init(item: loginButton, attribute: .height, relatedBy: .equal, toItem: passwordTextField, attribute: .height, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: loginButton, attribute: .width, relatedBy: .equal, toItem: passwordTextField, attribute: .width, multiplier: 1.0, constant: 0)])
        
        self.addConstraints([
            NSLayoutConstraint.init(item: loginLabel, attribute: .centerX, relatedBy: .equal, toItem: self.passwordTextField, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: loginLabel, attribute: .bottom, relatedBy: .equal, toItem: self.loginTextField, attribute: .top, multiplier: 1.0, constant: -30),
            NSLayoutConstraint.init(item: loginLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 100),
            NSLayoutConstraint.init(item: loginLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: Size.CMTextFieldSize.width)])
    }
    
}

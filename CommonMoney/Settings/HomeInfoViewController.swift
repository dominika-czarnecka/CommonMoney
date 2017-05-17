//
//  HomeInfoViewController.swift
//  CommonMoney
//
//  Created by Dominika Czarnecka on 17.05.2017.
//  Copyright © 2017 dominika.czarnecka. All rights reserved.
//

import UIKit

class HomeInfoViewController: BaseViewController {
    
    let cityTextField = CMTextField(type: "City")
    let adressTextField = CMTextField(type: "Adress")
    let idTextField = CMTextField(type: "Id")
    let adminTextField = CMTextField(type: "Admin")
    
    var editTapped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let editItem = UIBarButtonItem.init(title: "Edit", style: .done, target: self, action: #selector(editItemAction))
        self.navigationItem.setRightBarButton(editItem, animated: true)
        
        self.view.isUserInteractionEnabled = false
        
        self.view.addSubview(cityTextField)
        cityTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(adressTextField)
        adressTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(idTextField)
        idTextField.translatesAutoresizingMaskIntoConstraints = false
        idTextField.isUserInteractionEnabled = false
        
        self.view.addSubview(adminTextField)
        adminTextField.translatesAutoresizingMaskIntoConstraints = false
        
        if Constants.thisHome != nil{
            
            let admin = Constants.cotenents.first(where: { (cotenant) -> Bool in
                return cotenant.isAdmin!
            })
            
            adminTextField.titleLabel.text = "\(admin?.firstName ?? "No") \(admin?.lastName ?? "Admin")"
            cityTextField.titleLabel.text = Constants.thisHome?.city
            adressTextField.titleLabel.text = Constants.thisHome?.adress
            idTextField.titleLabel.text = Constants.thisHome?.id
            
        }

        setupConstraints()
    }
    
    func setupConstraints(){
        
        self.view.addConstraints([
            NSLayoutConstraint.init(item: idTextField, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: idTextField, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 25),
            NSLayoutConstraint.init(item: idTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 40),
            NSLayoutConstraint.init(item: idTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: Constants.Size.CMTextFieldSize.width)])
        
        self.view.addConstraints([
            NSLayoutConstraint.init(item: adminTextField, attribute: .centerX, relatedBy: .equal, toItem: self.idTextField, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: adminTextField, attribute: .top, relatedBy: .equal, toItem: self.idTextField, attribute: .bottom, multiplier: 1.0, constant: 15),
            NSLayoutConstraint.init(item: adminTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 40),
            NSLayoutConstraint.init(item: adminTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: Constants.Size.CMTextFieldSize.width)])
        
        self.view.addConstraints([
            NSLayoutConstraint.init(item: cityTextField, attribute: .centerX, relatedBy: .equal, toItem: self.adminTextField, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: cityTextField, attribute: .top, relatedBy: .equal, toItem: self.adminTextField, attribute: .bottom, multiplier: 1.0, constant: 15),
            NSLayoutConstraint.init(item: cityTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 40),
            NSLayoutConstraint.init(item: cityTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: Constants.Size.CMTextFieldSize.width)])
        
        self.view.addConstraints([
            NSLayoutConstraint.init(item: adressTextField, attribute: .centerX, relatedBy: .equal, toItem: self.cityTextField, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: adressTextField, attribute: .top, relatedBy: .equal, toItem: self.cityTextField, attribute: .bottom, multiplier: 1.0, constant: 15),
            NSLayoutConstraint.init(item: adressTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 40),
            NSLayoutConstraint.init(item: adressTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: Constants.Size.CMTextFieldSize.width)])
    }
    
    func editItemAction(sender: UIBarButtonItem){
        
        if editTapped{
            self.view.isUserInteractionEnabled = false
            sender.title = "Edit"
        }else{
            self.view.isUserInteractionEnabled = true
            sender.title = "Done"
        }
        
        editTapped = !editTapped
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


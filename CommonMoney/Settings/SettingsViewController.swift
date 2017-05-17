//
//  SettingsViewController.swift
//  CommonMoney
//
//  Created by Dominika Czarnecka on 17.05.2017.
//  Copyright © 2017 dominika.czarnecka. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import KVNProgress

class SettingsViewController: BaseViewController {

    let imageView = UIImageView.init()
    
    let nameTextField = CMTextField(type: "Name")
    let surnameTextField = CMTextField(type: "Surname")
    let emailTextField = CMTextField(type: "Email")
    let passwordTextField = CMTextField(type: "Password")

    var user: Cotenant?
    
    var editTapped = false
    
    init(user: Cotenant) {
        super.init()
        self.user = user
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let editItem = UIBarButtonItem.init(title: "Edit", style: .done, target: self, action: #selector(editItemAction))
        self.navigationItem.setRightBarButton(editItem, animated: true)
        
        self.view.isUserInteractionEnabled = false
        
        self.view.addSubview(imageView)
        imageView.layer.cornerRadius = 70
        imageView.backgroundColor = UIColor.blue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(surnameTextField)
        surnameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.titleLabel.isSecureTextEntry = true
        passwordTextField.titleLabel.text = "********"
        
        if user != nil{
            nameTextField.titleLabel.text = user?.firstName
            surnameTextField.titleLabel.text = user?.lastName
            emailTextField.titleLabel.text = user?.login
        }
        
        setupConstraints()
    }

    func setupConstraints(){
        
        self.view.addConstraints([
            NSLayoutConstraint.init(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: imageView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 25),
            NSLayoutConstraint.init(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 140),
            NSLayoutConstraint.init(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 140)])
        
        self.view.addConstraints([
            NSLayoutConstraint.init(item: nameTextField, attribute: .centerX, relatedBy: .equal, toItem: self.imageView, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: nameTextField, attribute: .top, relatedBy: .equal, toItem: self.imageView, attribute: .bottom, multiplier: 1.0, constant: 15),
            NSLayoutConstraint.init(item: nameTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 40),
            NSLayoutConstraint.init(item: nameTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: Constants.Size.CMTextFieldSize.width)])
        
        self.view.addConstraints([
            NSLayoutConstraint.init(item: surnameTextField, attribute: .centerX, relatedBy: .equal, toItem: self.nameTextField, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: surnameTextField, attribute: .top, relatedBy: .equal, toItem: self.nameTextField, attribute: .bottom, multiplier: 1.0, constant: 15),
            NSLayoutConstraint.init(item: surnameTextField, attribute: .height, relatedBy: .equal, toItem: self.nameTextField, attribute: .height, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: surnameTextField, attribute: .width, relatedBy: .equal, toItem: self.nameTextField, attribute: .width, multiplier: 1.0, constant: 0)])
        
        self.view.addConstraints([
            NSLayoutConstraint.init(item: emailTextField, attribute: .centerX, relatedBy: .equal, toItem: self.surnameTextField, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: emailTextField, attribute: .top, relatedBy: .equal, toItem: self.surnameTextField, attribute: .bottom, multiplier: 1.0, constant: 15),
            NSLayoutConstraint.init(item: emailTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 40),
            NSLayoutConstraint.init(item: emailTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: Constants.Size.CMTextFieldSize.width)])
        
        self.view.addConstraints([
            NSLayoutConstraint.init(item: passwordTextField, attribute: .centerX, relatedBy: .equal, toItem: self.emailTextField, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: passwordTextField, attribute: .top, relatedBy: .equal, toItem: self.emailTextField, attribute: .bottom, multiplier: 1.0, constant: 15),
            NSLayoutConstraint.init(item: passwordTextField, attribute: .height, relatedBy: .equal, toItem: self.emailTextField, attribute: .height, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: passwordTextField, attribute: .width, relatedBy: .equal, toItem: self.emailTextField, attribute: .width, multiplier: 1.0, constant: 0)])
    }
    
    func editItemAction(sender: UIBarButtonItem){
        
        if editTapped{
            self.view.isUserInteractionEnabled = false
            sender.title = "Edit"
            
            guard emailTextField.isValid(withPattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$") && passwordTextField.isValid(withPattern: "^.{6,}$") && nameTextField.isValid(withPattern: "^.+$")  && surnameTextField.isValid(withPattern: "^.+$") else{
                return
            }
            
            let user = FIRAuth.auth()?.currentUser;
            
            //TODO not finished
            let newUser = Cotenant.init(id: (user?.providerID)!, login: emailTextField.titleLabel.text!, firstName: nameTextField.titleLabel.text!, lastName: surnameTextField.titleLabel.text!, homeId: Constants.thisHome?.id, isAdmin: Constants.thisCotentant?.isAdmin)
            
            user?.updateEmail(emailTextField.titleLabel.text!, completion: { (error : Error?) in
                let alert = UIAlertController.init(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let alertAction = UIAlertAction.init(title: "Ok", style: .cancel, handler: { (UIAlertAction) in
                    alert.dismiss(animated: true, completion: nil)
                })
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
            })
            
        }else{
            self.view.isUserInteractionEnabled = true
            sender.title = "Done"
        }
        
        editTapped = !editTapped
    }
    
    func reload(user: Cotenant){
        nameTextField.titleLabel.text = user.firstName
        surnameTextField.titleLabel.text = user.lastName
        emailTextField.titleLabel.text = user.login
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

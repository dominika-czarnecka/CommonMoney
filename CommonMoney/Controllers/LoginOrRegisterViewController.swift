//
//  LoginViewController.swift
//  CommonMoney
//
//  Created by Dominika Czarnecka on 20.11.2016.
//  Copyright © 2016 dominika.czarnecka. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import KVNProgress
import ObjectMapper

class LoginOrRegisterViewController: BaseViewController, UIScrollViewDelegate {
    
    let ref = FIRDatabase.database().reference(withPath: "users")
    let refHome = FIRDatabase.database().reference(withPath: "homes")
    
    var cotenants: [Cotenant]?
    var bills: [Bill]?
    var homeID: String = ""
    
    let scrollView = UIScrollView()
    
    let loginView = LoginView()
    let registerView = RegisterView()
    
    let createHomeView = UIView()
    let homeIdTextField = CMTextField(type: "Home Id")
    let homeCotenants = CMTextField(type: "Home cotenant\n Id (opcional)")
    let createHomeButton = CMButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        //Notification for moving up view when keyboard show
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        
        let viewWidth = UIScreen.main.bounds.width
        let viewHeight = UIScreen.main.bounds.height
        
        scrollView.contentSize = CGSize.init(width: viewWidth * 3, height: 0)
        
        loginView.frame = CGRect.init(x: 0, y: 0, width: viewWidth, height: viewHeight)
        registerView.frame = CGRect.init(x: viewWidth, y: 0, width: viewWidth, height: viewHeight)
        createHomeView.frame = CGRect.init(x: viewWidth * 2, y: 0, width: viewWidth, height: viewHeight)
        
        //MARK: LoginView
        scrollView.addSubview(loginView)
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        loginView.loginLabel.text = "Log in or swipe your finger to left to sing up"
        loginView.loginButton.setTitle("Login", for: .normal)
        loginView.loginButton.titleLabel?.font = UIFont.appFont(bold: true, fontSize: 14)
        loginView.loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        
        //MARK: RegisterView
        scrollView.addSubview(registerView)
        registerView.backgroundColor = UIColor.clear
        
        registerView.translatesAutoresizingMaskIntoConstraints = false
        self.registerView.registerLabel.text = "Sing up or swipe your finger to right to log in"
        self.registerView.regButton.setTitle("Sing up", for: .normal)
        self.registerView.regButton.addTarget(self, action: #selector(registrationButtonAction), for: .touchUpInside)
        
        scrollView.addSubview(createHomeView)
        createHomeView.backgroundColor = UIColor.clear
        
        createHomeView.addSubview(homeIdTextField)
        homeIdTextField.translatesAutoresizingMaskIntoConstraints = false
        
        createHomeView.addSubview(homeCotenants)
        homeCotenants.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstants()
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Constraints
    func setupConstants(){
        
        self.view.addConstraints([
            NSLayoutConstraint.init(item: scrollView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: scrollView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: scrollView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: scrollView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0)])
        
        self.scrollView.addConstraints([
            NSLayoutConstraint.init(item: loginView, attribute: .left, relatedBy: .equal, toItem: self.scrollView, attribute: .left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: loginView, attribute: .centerY, relatedBy: .equal, toItem: self.scrollView, attribute: .centerY, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: loginView, attribute: .height, relatedBy: .equal, toItem: self.scrollView, attribute: .height, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: loginView, attribute: .width, relatedBy: .equal, toItem: self.scrollView, attribute: .width, multiplier: 1.0, constant: 0)])
        
        self.scrollView.addConstraints([
            NSLayoutConstraint.init(item: registerView, attribute: .left, relatedBy: .equal, toItem: self.loginView, attribute: .right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: registerView, attribute: .centerY, relatedBy: .equal, toItem: self.scrollView, attribute: .centerY, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: registerView, attribute: .height, relatedBy: .equal, toItem: self.scrollView, attribute: .height, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: registerView, attribute: .width, relatedBy: .equal, toItem: self.scrollView, attribute: .width, multiplier: 1.0, constant: 0)])
        
    }
    
    //MARK: Buttons actions
    func loginButtonAction(){
        //TODO: change before realase
        
        //        guard let email = loginView.loginTextField.titleLabel.text, let password = loginView.passwordTextField.titleLabel.text else {
        //            loginView.loginTextField.shake()
        //            loginView.passwordTextField.shake()
        //            return
        //        }
        //
        //        FIRAuth.auth()?.signIn(withEmail: email, password: password) { ( user, error) in
        //            if let error = error {
        //                print(error.localizedDescription)
        //                self.loginView.passwordTextField.shake()
        //                self.loginView.loginTextField.shake()
        //                return
        //            }
        
        FIRAuth.auth()?.signIn(withEmail: "dominika@gmail.com", password: "dominika") { ( user, error) in
            
            if let error = error {
                print(error.localizedDescription)
                self.loginView.passwordTextField.shake()
                self.loginView.loginTextField.shake()
                return
            }
            
            self.ref.queryOrdered(byChild: "id").observe(.childAdded, with: { (snapshot) in
                
                if let owner = Mapper<Cotenant>().map(JSON: snapshot.value as? [String : Any] ?? [:]) {
                    
                    if owner.login == user?.email{
                        
                        UserDefaults.standard.set(owner.homeId, forKey: "thisHomeID")
                        UserDefaults.standard.set(owner.id, forKey: "thisContenant")
                        UserDefaults.standard.set(owner.firstName, forKey: "thisContenantFirstName")
                        UserDefaults.standard.set(owner.lastName, forKey: "thisContenantLastName")
                        self.navigationController?.pushViewController(MainViewController(), animated: true)
                        return
                    }
                }
            })
        }
    }
    
    func registrationButtonAction(){
        
        guard let email = registerView.regLoginTextField.titleLabel.text,
            let password = registerView.regPasswordTextField.titleLabel.text,
            let firstName = registerView.regFirstNameTextField.titleLabel.text,
            let lastName = registerView.regLastNameTextField.titleLabel.text else{
                
                return
        }
        
        guard registerView.regLoginTextField.isValid(withPattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$") && registerView.regPasswordTextField.isValid(withPattern: "^.{6,}$") && registerView.regFirstNameTextField.isValid(withPattern: "^.+$")  && registerView.regLastNameTextField.isValid(withPattern: "^.+$") else{
            return
        }
        
        if registerView.regHomeTextField.titleLabel.text == ""{
            
            let homeRegisterAlert = UIAlertController.init(title: "Home register", message: "You haven't entered homeID, would you like to register a new home?", preferredStyle: .alert)
            
            homeRegisterAlert.addAction(UIAlertAction.init(title: "Yes", style: .default, handler: { (_) in
                
                let newHomeRef = self.refHome
                    .childByAutoId()
                
                self.homeID = newHomeRef.key
                
                UserDefaults.standard.set(self.homeID, forKey: "thisHomeID")
                
                let home = Home.init(id: self.homeID)
                
                newHomeRef.setValue(home.toJSON())
                
                KVNProgress.showSuccess(withStatus: "Home registred")
                
                FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                }
                
                let newCotenantRef = self.ref.childByAutoId()
                
                let cotenantID: String = newCotenantRef.key
                
                UserDefaults.standard.set(cotenantID, forKey: "thisContenant")
                
                let cotenant = Cotenant.init(id: cotenantID, login: email, firstName: firstName, lastName: lastName, homeId: self.homeID, isAdmin: true)
                
                newCotenantRef.setValue(cotenant.toJSON())
                
                self.navigationController?.pushViewController(MainViewController(), animated: true)
                
            }))
            
            homeRegisterAlert.addAction(UIAlertAction.init(title: "No", style: .cancel, handler: nil))
            
            self.present(homeRegisterAlert, animated: true, completion: nil)
            
        }else{
            
            FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }
            
            let newCotenantRef = self.ref.childByAutoId()
            
            let cotenantID = newCotenantRef.key
            
            let cotenant = Cotenant.init(id: cotenantID, login: email, firstName: firstName, lastName: lastName, homeId: self.homeID, isAdmin: false)
            
            newCotenantRef.setValue(cotenant.toJSON())
            
            self.navigationController?.pushViewController(MainViewController(), animated: true)
            
        }
        
    }
    
    //MARK: TextField and keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return false to ignore.
    {
        textField.resignFirstResponder()
        return true
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue{
            self.view.transform = CGAffineTransform.init(translationX: 0, y: -keyboardSize.height * 0.5)
            
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.view.transform = CGAffineTransform.init(translationX: 0, y: 0)
    }
    
}

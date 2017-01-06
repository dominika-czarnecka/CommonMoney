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

class LoginOrRegisterViewController: BaseViewController, UIScrollViewDelegate {
    
    let ref = FIRDatabase.database().reference(withPath: "users")
    
    var cotenants: [Cotenant]?
    var bills: [Bill]?
    var homes: [Home]?
    
    let scrollView = UIScrollView()
    
    let loginView = LoginView()
    let registerView = RegisterView()
    
    //TODO: RegisterHomeView
    
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
        scrollView.alwaysBounceVertical = false
        
        let viewWidth = UIScreen.main.bounds.width
        let viewHeight = UIScreen.main.bounds.height
        
        scrollView.contentSize = CGSize.init(width: viewWidth * 3, height: viewHeight)
        
        loginView.frame = CGRect.init(x: 0, y: 0, width: viewWidth, height: viewHeight)
        registerView.frame = CGRect.init(x: viewWidth, y: 0, width: viewWidth, height: viewHeight)
        createHomeView.frame = CGRect.init(x: viewWidth * 2, y: 0, width: viewWidth, height: viewHeight)
        
        //MARK: LoginView
        scrollView.addSubview(loginView)

        loginView.translatesAutoresizingMaskIntoConstraints = false
        loginView.loginLabel.text = "Log in or swipe your finger to left to sing up"
        loginView.loginButton.setTitle("Login", for: .normal)
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
        
        guard let email = loginView.loginTextField.titleLabel.text, let password = loginView.passwordTextField.titleLabel.text else {
            loginView.loginTextField.shake()
            loginView.passwordTextField.shake()
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { ( user, error) in
            if let error = error {
                print(error.localizedDescription)
                self.loginView.passwordTextField.shake()
                self.loginView.loginTextField.shake()
                return
            }
            
            self.navigationController?.pushViewController(MainViewController(), animated: true)
        }
    }
    
    func registrationButtonAction(){
        
        guard let email = registerView.regLoginTextField.titleLabel.text, let password = registerView.regPasswordTextField.titleLabel.text, let firstName = registerView.regFirstNameTextField.titleLabel.text, let lastName = registerView.regLastNameTextField.titleLabel.text else {
            return
        }

        if registerView.regLoginTextField.isValid(withPattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$") && registerView.regPasswordTextField.isValid(withPattern: "^.{6,}$"){
            
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
        
        let cotenant = Cotenant.init(login: email, firstName: firstName, lastName: lastName, homeId: nil, isAdmin: false)
        
        // 3
        let cotenantItemRef = self.ref.child(email).childByAutoId()
        
        // 4
        cotenantItemRef.setValue(cotenant.toJSON())
        
        self.navigationController?.pushViewController(MainViewController(), animated: true)
        
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
            
//            self.scrollView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.view.transform = CGAffineTransform.init(translationX: 0, y: 0)
    }
    
}

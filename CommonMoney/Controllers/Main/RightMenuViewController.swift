//
//  RightMenuViewController.swift
//  CommonMoney
//
//  Created by Dominika Czarnecka on 23.01.2017.
//  Copyright © 2017 dominika.czarnecka. All rights reserved.
//

import UIKit
import FirebaseDatabase

class RightMenuViewController: UIViewController {

    //let imageButton = UIButton()

    let userTextField = CMTextField.init(type: "User")
    let homeTextField = CMTextField.init(type: "HomeID")
    
    let logoutButton = CMButton()
    let deleteAccount = CMButton()
    
    let cotenant = Constants.thisCotentant
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(userTextField)
        userTextField.translatesAutoresizingMaskIntoConstraints = false
        userTextField.isUserInteractionEnabled = false
        
        self.view.addSubview(homeTextField)
        homeTextField.translatesAutoresizingMaskIntoConstraints = false
        homeTextField.isUserInteractionEnabled = false
        
        self.view.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
       // logoutButton.setTitleColor(UIColor.black, for: .normal)
        logoutButton.setTitle("Logout", for: .normal)
//        self.view.addSubview(deleteAccount)
//        deleteAccount.translatesAutoresizingMaskIntoConstraints = false
//        deleteAccount.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        
        setupConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.userTextField.titleLabel.text = (self.cotenant?.firstName ?? "") + " " + (self.cotenant?.lastName ?? "")
        
        self.homeTextField.titleLabel.text = self.cotenant?.homeId
        
    }

    func setupConstraints(){
        
        self.view.addConstraints([
            NSLayoutConstraint.init(item: userTextField, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: userTextField, attribute: .top, relatedBy: .equal,toItem: view, attribute: .top, multiplier: 1.0, constant: 230),
            NSLayoutConstraint.init(item: userTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant:200 ),
            NSLayoutConstraint.init(item: userTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 40)])
        
        self.view.addConstraints([
            NSLayoutConstraint.init(item: homeTextField, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: homeTextField, attribute: .top, relatedBy: .equal,toItem: userTextField, attribute: .bottom, multiplier: 1.0, constant: 10),
            NSLayoutConstraint.init(item: homeTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant:200),
            NSLayoutConstraint.init(item: homeTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 40)])
        
        self.view.addConstraints([
            NSLayoutConstraint.init(item: logoutButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: logoutButton, attribute: .top, relatedBy: .equal,toItem: homeTextField, attribute: .bottom, multiplier: 1.0, constant: 10),
            NSLayoutConstraint.init(item: logoutButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant:200),
            NSLayoutConstraint.init(item: logoutButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 40)])
        
//        self.view.addConstraints([
//            NSLayoutConstraint.init(item: deleteAccount, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0),
//            NSLayoutConstraint.init(item: deleteAccount, attribute: .top, relatedBy: .equal,toItem: logoutButton, attribute: .bottom, multiplier: 1.0, constant: 10),
//            NSLayoutConstraint.init(item: deleteAccount, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant:Size.CMTextFieldSize.width),
//            NSLayoutConstraint.init(item: deleteAccount, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 40)])
        
    }
    
    func logoutAction(){
        
        Constants.thisCotentant = nil
//        UserDefaults.standard.removeObject(forKey: "thisContenantFirstName")
//        UserDefaults.standard.removeObject(forKey: "thisContenantLastName")
//        UserDefaults.standard.removeObject(forKey: "thisHomeID")
        
        self.mm_drawerController.closeDrawer(animated: true, completion: nil)
       _ = (self.mm_drawerController.centerViewController as? UINavigationController)?.popToRootViewController(animated: true)
    }
    
//    func deleteAction(){
//        
//        let refOwners = FIRDatabase.database().reference(withPath: "users").queryOrdered(byChild: "homeId").queryEqual(toValue: UserDefaults.standard.object( forKey: "thisHomeID"))
//        let confirmAlert = UIAlertController.init(title: "Logout", message: "Are u sure u want to logout? ", preferredStyle: .alert)
//        confirmAlert.addAction(UIAlertAction.init(title: "Yes", style: .default, handler: { (UIAlertAction) in
//            
//            guard ((UserDefaults.standard.object( forKey: "thisContenant") as? String) != nil) else{
//                return
//            }
//            
//            refOwners.child((self.bill?.id)!).removeValue { (error, ref) in
//                if error != nil {
//                    print("error \(error)")
//                }else{
//                    _ = self.navigationController?.popViewController(animated: true)
//                }
//            }
//            
//            refOwners.child((self.bill?.id)!).removeValue { (error, ref) in
//                if error != nil {
//                    print("error \(error)")
//                }else{
//                    _ = self.navigationController?.popViewController(animated: true)
//                }
//            }
//            
//            
//            UserDefaults.standard.removeObject(forKey: "thisContenant")
//            UserDefaults.standard.removeObject(forKey: "thisContenantFirstName")
//            UserDefaults.standard.removeObject(forKey: "thisContenantLastName")
//            UserDefaults.standard.removeObject(forKey: "thisHomeID")
//            
//            
//            
//        }))
//        confirmAlert.addAction(UIAlertAction.init(title: "No", style: .cancel, handler: nil))
//        self.present(confirmAlert, animated: true, completion: nil)
//        
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//
//  LeftMenuViewController.swift
//  CommonMoney
//
//  Created by Dominika Czarnecka on 04.05.2017.
//  Copyright © 2017 dominika.czarnecka. All rights reserved.
//

import UIKit
import FirebaseDatabase

class LeftMenuViewController: UIViewController {

    let settingsButton = UIButton()
    let homeButton = UIButton()
    let colaborantsButton = UIButton()
    let historyButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        self.settingsButton.translatesAutoresizingMaskIntoConstraints = false
        self.settingsButton.layer.cornerRadius = 20
        self.settingsButton.setImage(#imageLiteral(resourceName: "settings"), for: .normal)
        self.settingsButton.tintColor = Constants.Colors.purple
        self.view.addSubview(settingsButton)
        
        self.homeButton.translatesAutoresizingMaskIntoConstraints = false
        self.homeButton.layer.cornerRadius = 20
        self.homeButton.setImage(#imageLiteral(resourceName: "home"), for: UIControlState.normal)
        self.homeButton.tintColor = Constants.Colors.purple
        self.view.addSubview(homeButton)
        
        self.colaborantsButton.translatesAutoresizingMaskIntoConstraints = false
        self.colaborantsButton.layer.cornerRadius = 20
        self.colaborantsButton.setImage(#imageLiteral(resourceName: "colaborants"), for: UIControlState.normal)
        self.colaborantsButton.tintColor = Constants.Colors.purple
        self.view.addSubview(colaborantsButton)
        
        self.historyButton.translatesAutoresizingMaskIntoConstraints = false
        self.historyButton.layer.cornerRadius = 20
        self.historyButton.setImage(#imageLiteral(resourceName: "clock"), for: UIControlState.normal)
        self.historyButton.tintColor = Constants.Colors.purple
        self.historyButton.addTarget(self, action: #selector(historyAction), for: .touchUpInside)
        self.view.addSubview(historyButton)

        self.view.addConstraints([
            NSLayoutConstraint.init(item: settingsButton, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 70),
            NSLayoutConstraint.init(item: settingsButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: settingsButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 50),
            NSLayoutConstraint.init(item: settingsButton, attribute: .width, relatedBy: .equal, toItem: self.settingsButton, attribute: .height, multiplier: 1.0, constant: 0)])
       
        self.view.addConstraints([
            NSLayoutConstraint.init(item: homeButton, attribute: .top, relatedBy: .equal, toItem: self.settingsButton, attribute: .bottom, multiplier: 1.0, constant: 10),
            NSLayoutConstraint.init(item: homeButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: homeButton, attribute: .height, relatedBy: .equal, toItem: self.settingsButton, attribute: .height, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: homeButton, attribute: .width, relatedBy: .equal, toItem: self.homeButton, attribute: .height, multiplier: 1.0, constant: 0)])
        
        self.view.addConstraints([
            NSLayoutConstraint.init(item: colaborantsButton, attribute: .top, relatedBy: .equal, toItem: self.homeButton, attribute: .bottom, multiplier: 1.0, constant: 10),
            NSLayoutConstraint.init(item: colaborantsButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: colaborantsButton, attribute: .height, relatedBy: .equal, toItem: self.settingsButton, attribute: .height, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: colaborantsButton, attribute: .width, relatedBy: .equal, toItem: self.colaborantsButton, attribute: .height, multiplier: 1.0, constant: 0)])
        
        self.view.addConstraints([
            NSLayoutConstraint.init(item: historyButton, attribute: .top, relatedBy: .equal, toItem: self.colaborantsButton, attribute: .bottom, multiplier: 1.0, constant: 10),
            NSLayoutConstraint.init(item: historyButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: historyButton, attribute: .height, relatedBy: .equal, toItem: self.settingsButton, attribute: .height, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: historyButton, attribute: .width, relatedBy: .equal, toItem: self.historyButton, attribute: .height, multiplier: 1.0, constant: 0)])
        
    }

    func historyAction(){
         self.mm_drawerController.closeDrawer(animated: true, completion: { (Bool) in
            (self.mm_drawerController.centerViewController as! UINavigationController).pushViewController(HistoryViewController(), animated: true)
         })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

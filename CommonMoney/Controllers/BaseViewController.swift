//
//  BaseViewController.swift
//  CommonMoney
//
//  Created by Dominika Czarnecka on 20.11.2016.
//  Copyright © 2016 dominika.czarnecka. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    init(){
      super.init(nibName: nil, bundle: nil)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        gradient.colors = [Constants.Colors.purple.cgColor, Constants.Colors.lightBlue.cgColor]
        gradient.locations = [0.0, 0.7, 1.0]
        gradient.startPoint = CGPoint.init(x: 0.5, y: 0)
        gradient.endPoint = CGPoint.init(x: 0.5, y: 1)
        self.view.layer.insertSublayer(gradient, at: 0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//
//  CMButton.swift
//  CommonMoney
//
//  Created by Dominika Czarnecka on 23.11.2016.
//  Copyright © 2016 dominika.czarnecka. All rights reserved.
//

import UIKit

class CMButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 15
        self.setTitleColor(Colors.darkBlue, for: .normal)
        
        self.layer.borderWidth = 4
        self.layer.borderColor = Colors.darkBlue.cgColor
        
        self.addTarget(self, action: #selector(beginTracking), for: .touchDown)
        self.addTarget(self, action: #selector(endTracking), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: 1,y: 1)
        }
    }
    
}

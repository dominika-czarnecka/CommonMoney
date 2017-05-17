//
//  Constans.swift
//  CommonMoney
//
//  Created by Dominika Czarnecka on 20.11.2016.
//  Copyright © 2016 dominika.czarnecka. All rights reserved.
//

import UIKit

struct Constants{
    
    static var thisCotentant: Cotenant?
    static var thisHome: Home?
    static var cotenents: [Cotenant] = []
    
    struct Colors{
        
        static let lightGray = UIColor(red:0.86, green:0.86, blue:0.86, alpha:1.00)
        static let purple = UIColor(red:0.00, green:0.59, blue:0.83, alpha:1.00)
        static let lightBlue = UIColor(red:0.00, green:0.79, blue:1, alpha:1.00)
    }
    
    struct Space{
        static let CMTtextFieldSpace: CGFloat = 30
    }
    
    struct Size{
        
        static let CMTextFieldSize = CGSize.init(width: UIScreen.main.bounds.width - 100, height: 45)
        
    }
}

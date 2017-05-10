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
    static var cotenents: [Cotenant] = []
    
    struct Colors{
        
        static let lightGray = UIColor(red:0.86, green:0.86, blue:0.86, alpha:1.00)
        static let navBarBlue = UIColor(red:0.62, green:1.00, blue:1.00, alpha:1.00)
        static let purple = UIColor(red:0.56, green:0.61, blue:0.87, alpha:1.00)
        static let buttonBlue = UIColor(red:0.00, green:0.59, blue:0.83, alpha:1.00)
    }
    
    struct Space{
        static let CMTtextFieldSpace: CGFloat = 30
    }
    
    struct Size{
        
        static let CMTextFieldSize = CGSize.init(width: UIScreen.main.bounds.width - 100, height: 45)
        
    }
}

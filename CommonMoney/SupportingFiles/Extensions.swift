//
//  Extensions.swift
//  CommonMoney
//
//  Created by Dominika Czarnecka on 20.11.2016.
//  Copyright © 2016 dominika.czarnecka. All rights reserved.
//

//MARK: UIFont

import UIKit

extension UIFont {
    
    class func appFont(bold: Bool,italic: Bool = false,medium: Bool = false, fontSize: CGFloat) -> UIFont {
        
        let finalFontSize: CGFloat = fontSize
        
        let regularFontName: String = "FiraSans-Regular"
        let boldFontName: String = "FiraSans-Bold"
        let italicFontName = "FiraSans-Italic"
        let boldItalicFontName = "FiraSans-BoldItalic"
        let mediumFontName = "FiraSans-Medium"
        
        if !bold && !italic && !medium{
            return UIFont(name: regularFontName, size: finalFontSize)!
        } else if bold && italic{
            return UIFont(name: boldItalicFontName, size: finalFontSize)!
        }else if bold {
            return UIFont(name: boldFontName, size: finalFontSize)!
        }else if medium{
            return UIFont(name: mediumFontName, size: finalFontSize)!
        }else{
            return UIFont(name: italicFontName, size: finalFontSize)!
        }
    }
    
    func appFont(bold: Bool, fontSize: CGFloat) -> UIFont {
        return UIFont.appFont(bold: bold, fontSize: fontSize)
    }
}

extension UILabel{
    
    func setupAsMultipleLineLabel(){
        
    }
    
}

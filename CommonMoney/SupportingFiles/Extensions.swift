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

extension Date {
    
    func isToday() -> Bool {
        return NSCalendar.current.isDateInToday(self)
    }
    
    func dateToString(format: String) -> String{
        let formatter = DateFormatter()
        let locale = NSLocale(localeIdentifier: "en_US_POSIX")
        
        formatter.locale = locale as Locale!
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
    
    func isGreaterThanDate(dateToCompare: Date) -> Bool {
        var isGreater = false
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        return isGreater
    }
    
    func isLessThanDate(dateToCompare: Date) -> Bool {
        var isLess = false
        if self.compare(dateToCompare) == ComparisonResult.orderedAscending {
            isLess = true
        }
        return isLess
    }
    
    func equalToDate(dateToCompare: Date) -> Bool {
        var isEqualTo = false
        if self.compare(dateToCompare) == ComparisonResult.orderedSame {
            isEqualTo = true
        }
        return isEqualTo
    }
    
    func localDate() -> Date{
        
        var dayComponent = DateComponents.init()
        var theCalendar = Calendar.current
        theCalendar.timeZone = TimeZone.init(identifier: "GMT")!
        dayComponent = (Calendar.current as NSCalendar).components([NSCalendar.Unit.hour, NSCalendar.Unit.minute, .second, .day, .month, .year], from: self)
        return theCalendar.date(from: dayComponent)!
        
    }
    
}

extension UIImage{
    
    func toBase64(quality: CGFloat) -> String{
        
        let data = UIImageJPEGRepresentation(self, quality)
        let string = (data?.base64EncodedString(options: NSData.Base64EncodingOptions.endLineWithLineFeed))!

        return string

    }
    // convert images into base64 and keep them into string
    
}

extension String{
    func convertBase64ToImage() -> UIImage {
        
        let decodedData = NSData(base64Encoded: self, options: NSData.Base64DecodingOptions(rawValue: 0) )
        
        guard decodedData != nil else {
            return UIImage()
        }
        
        let decodedimage = UIImage(data: decodedData! as Data)
        
        guard decodedimage != nil else {
            return UIImage()
        }
        
        return decodedimage!
        
    }
}


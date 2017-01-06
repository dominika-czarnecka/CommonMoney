//
//  Home.swift
//  CommonMoney
//
//  Created by Dominika Czarnecka on 23.11.2016.
//  Copyright © 2016 dominika.czarnecka. All rights reserved.
//

import UIKit
import ObjectMapper

class Home: Mappable{

    var id: Int?
    var cotenants: [Cotenant]?
    var bills: [Bill]?

    init(cotenants: [Cotenant]){
        self.cotenants = cotenants
    }
    
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    public required init?(map: Map) {
        if map.JSON["id"] == nil{
            return nil
        }
    }
    
    func mapping(map: Map){
        self.id <- map["id"]
        self.cotenants <- map["cotenants"]
        self.bills <- map["bills"]
    }
    
}

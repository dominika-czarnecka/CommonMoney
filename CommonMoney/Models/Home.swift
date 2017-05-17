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

    var id: String?
    var city: String?
    var adress: String?
    var budget: Double?
    var budgetDate: Double?

    init(id: String){
        self.id = id
        self.budget = 0
        self.budgetDate = Date().timeIntervalSince1970
        //TODO home adress
        self.city = "Poznań"
        self.adress = "Adress 3a"
    }
    
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    public required init?(map: Map) {
        if map.JSON["id"] == nil{
            return nil
        }
    }
    
    func mapping(map: Map){
        self.id <- map["id"]
        self.budget <- map["budget"]
        self.budgetDate <- map["budgetDate"]
    }
}

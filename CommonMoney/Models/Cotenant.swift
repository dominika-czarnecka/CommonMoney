//
//  Cotenant.swift
//  CommonMoney
//
//  Created by Dominika Czarnecka on 20.11.2016.
//  Copyright © 2016 dominika.czarnecka. All rights reserved.
//

import UIKit
import ObjectMapper

class Cotenant: Mappable {
    
    var id: String?
    var login: String?
    var firstName: String?
    var lastName: String?
    var homeId: String?
    var isAdmin: Bool?
    
    init(id: String, login: String, firstName: String, lastName: String, homeId: String?, isAdmin: Bool?) {
        self.id = id
        self.login = login
        self.firstName = firstName
        self.lastName = lastName
        self.homeId = homeId
        self.isAdmin = isAdmin
    }
    
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    public required init?(map: Map) {
        if map.JSON["id"] == nil{
            return nil
        }
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.login <- map["login"]
        self.firstName <-  map["firstName"]
        self.lastName <- map["lastName"]
        self.homeId <- map["homeId"]
        self.isAdmin <- map["isAdmin"]
    }
    
}

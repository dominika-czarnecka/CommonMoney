//
//  Bill.swift
//  CommonMoney
//
//  Created by Dominika Czarnecka on 20.11.2016.
//  Copyright © 2016 dominika.czarnecka. All rights reserved.
//

import UIKit
import ObjectMapper

enum BillType: String{
    case Food
    case others
}

class Bill: Mappable {
    
    var id: String?
    var homeID: String?
    var title: String?
    var ownerId: String?
    var date: Double?
    var price: Float?
    var type: String?//BillType?
    var photo: String?
    
    init(id: String, homeID: String, title: String, ownerId: String, date: Double, fullPrice: Float, type: String, photo: String?) {
        self.id = id
        self.homeID = homeID
        self.title = title
        self.date = date
        self.ownerId = ownerId
        self.price = fullPrice
        self.type = type
        self.photo = photo
    }
    
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    public required init?(map: Map) {
        if map.JSON["id"] == nil{
            return nil
        }
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.homeID <- map["homeID"]
        self.title <- map["title"]
        self.ownerId <- map["ownerId"]
        self.price <- map["fullPrice"]
        self.type <- map["type"]
        self.photo <- map["photo"]
        self.date <- map["date"]
    }
    
}

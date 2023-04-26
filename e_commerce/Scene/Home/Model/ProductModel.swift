//
//  ProductModel.swift
//  e_commerce
//
//  Created by Nguyen Dang Trong Thai on 4/26/23.
//

import Foundation
import ObjectMapper

class ProductModel: Mappable {
    var id: Int = 0
    var title: String = ""
    var price: Double = 0
    var description: String = ""
    var category: String = ""
    var image: String = ""
    var rate: Double = 0
    var count: Int = 0
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        price <- map["price"]
        description <- map["description"]
        category <- map["category"]
        image <- map["image"]
        rate <- map["rating.rate"]
        count <- map["rating.count"]
    }
}

//
//  ProductModelOffline.swift
//  e_commerce
//
//  Created by Nguyen Dang Trong Thai on 4/28/23.
//

import Foundation
import RealmSwift

class ProductOffline: Object {
    @Persisted(primaryKey: true) var id_: Int = UUID().hashValue
    @Persisted var id: Int
    @Persisted var title: String
    @Persisted var price: Double
    @Persisted var descrip: String
    @Persisted var category: String
    @Persisted var image: String
    @Persisted var rate: Double
    @Persisted var count: Int
    @Persisted var quantity: Int
}

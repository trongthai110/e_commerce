//
//  OrderViewModel.swift
//  e_commerce
//
//  Created by Nguyen Dang Trong Thai on 4/28/23.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import RealmSwift


class OrderViewModel {
    let title = BehaviorSubject<String>(value: "Order")
    let navigateToSubmit = PublishRelay<Void>()
    var productResult: [ProductOffline] = []
    let totalPrice = BehaviorRelay<Double>(value: 0)
    let realm = try! Realm()
    
    func submitTapped() {
        navigateToSubmit.accept(())
        print("Go to Submit")
    }
    
    func getProductOffline() {
        productResult = []
        let list = realm.objects(ProductOffline.self).toArray(ofType: ProductOffline.self)
        
        list.forEach { productResult.append($0) }
        
        let total = list.reduce(0, { $0 + $1.price * Double($1.quantity) })
        totalPrice.accept(total)
        print(total)
    }
}

//
//  CartViewModel.swift
//  e_commerce
//
//  Created by Nguyen Dang Trong Thai on 4/27/23.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import RealmSwift


class CartViewModel {
    let title = BehaviorSubject<String>(value: "Cart")
    let navigateToOrder = PublishRelay<Void>()
    let productTotal = PublishSubject<Array<IndexPath>>()
    let totalPrice = BehaviorRelay<Double>(value: 0)
    var productResult: [ProductOffline] = []
    let realm = try! Realm()
    
    func checkoutTapped() {
        navigateToOrder.accept(())
        print("Go to Order")
    }
    
    func getProductOffline() {
        productResult = []
        let list = realm.objects(ProductOffline.self).toArray(ofType: ProductOffline.self)
        
        list.forEach { productResult.append($0) }
        
        let total = list.reduce(0, { $0 + $1.price * Double($1.quantity) })
        totalPrice.accept(total)
        print(total)
    }
    
    func handleProductOffline(for data: ProductOffline, for isPlus: Bool, for index: Array<IndexPath>) {
        if isPlus == true {
            if let productObject = realm.objects(ProductOffline.self).filter("id == \(data.id)").first {
                try! realm.write {
                    productObject.quantity += 1
                }
            }
        } else {
            if let productObject = realm.objects(ProductOffline.self).filter("id == \(data.id)").first {
                try! realm.write {
                    productObject.quantity -= 1
                    if productObject.quantity <= 0 {
                        realm.delete(productObject)
                    }
                }
            }
        }
        getProductOffline()
        productTotal.onNext(index)
    }
}

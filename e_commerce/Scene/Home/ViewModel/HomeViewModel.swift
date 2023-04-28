//
//  HomeViewModel.swift
//  e_commerce
//
//  Created by Nguyen Dang Trong Thai on 4/26/23.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import RealmSwift


class HomeViewModel {
    
    let idProduct = PublishSubject<Int>()
    let navigateToCart = PublishRelay<Void>()
    let productQuantity = PublishSubject<Int>()
    let title = BehaviorSubject<String>(value: "Shop")
    let realm = try! Realm()
    
    func onTapped(id: Int) {
        idProduct.onNext(id)
        print("cell tapped")
    }
    
    func cartTapped() {
        navigateToCart.accept(())
        print("Go to cart")
    }
    
    func addToCart(for data: ProductModel) {
        print("Add to cart", data.price)
        
        if let productObject = realm.objects(ProductOffline.self).filter("id == \(data.id)").first {
            try! realm.write {
                productObject.quantity += 1
            }
        } else {
            let productObject = ProductOffline()
            productObject.id = data.id
            productObject.title = data.title
            productObject.price = data.price
            productObject.descrip = data.description
            productObject.category = data.category
            productObject.image = data.image
            productObject.rate = data.rate
            productObject.count = data.count
            productObject.quantity = 1
            try! realm.write {
                realm.add(productObject)
            }
        }
        getProductQuantity()
    }
    
    func getProductQuantity() {
        let list = realm.objects(ProductOffline.self).toArray(ofType: ProductOffline.self)
        productQuantity.onNext(list.count)
    }
}

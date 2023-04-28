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
}

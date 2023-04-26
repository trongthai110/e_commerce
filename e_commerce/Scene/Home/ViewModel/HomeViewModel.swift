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


class HomeViewModel {
    
    let navigateToDetail = PublishRelay<Void>()
    let idProduct = PublishSubject<Int>()
    
    func onTapped(id: Int) {
        //navigateToDetail.accept(())
        idProduct.onNext(id)
        print("cell tapped")
    }
}

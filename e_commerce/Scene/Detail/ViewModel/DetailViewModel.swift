//
//  DetailViewModel.swift
//  e_commerce
//
//  Created by Nguyen Dang Trong Thai on 4/26/23.
//

import Foundation
import RxSwift
import RxCocoa
import Moya


class DetailViewModel {
    
    private let disposeBag = DisposeBag()
    let title = BehaviorSubject<String>(value: "Detail")
    let id: Int
    
    init(id: Int) {
        self.id = id
    }
}

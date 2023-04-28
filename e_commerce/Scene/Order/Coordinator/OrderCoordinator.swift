//
//  OrderCoordinator.swift
//  e_commerce
//
//  Created by Nguyen Dang Trong Thai on 4/28/23.
//

import UIKit
import RxSwift

class OrderCoordinator: BaseCoordinator<Void> {
    
    private let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() -> Observable<Void> {
        let viewModel = OrderViewModel()
        let viewController = OrderViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
        
        viewController.viewModel = viewModel
        
        return Observable.never()
    }
}

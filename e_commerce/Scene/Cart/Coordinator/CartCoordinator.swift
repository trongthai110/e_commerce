//
//  CartCoordinator.swift
//  e_commerce
//
//  Created by Nguyen Dang Trong Thai on 4/27/23.
//

import UIKit
import RxSwift

class CartCoordinator: BaseCoordinator<Void> {
    
    private let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    override func start() -> Observable<Void> {
        let viewModel = CartViewModel()
        let viewController = CartViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
        
        viewController.viewModel = viewModel
        
        viewModel.navigateToCheckout.subscribe(onNext: { [weak self] in
            self?.showOrder(in: self!.navigationController)

        }).disposed(by: disposeBag)
        
        return Observable.never()
    }
    
    private func showOrder(in navigationController: UINavigationController) {
        let orderCoordinator = OrderCoordinator(navigationController: navigationController)
        coordinate(to: orderCoordinator)
            .subscribe()
            .disposed(by: disposeBag)
    }
}

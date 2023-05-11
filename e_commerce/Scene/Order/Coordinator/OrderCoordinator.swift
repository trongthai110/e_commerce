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
        
        viewModel.navigateToSubmit.subscribe(onNext: { [weak self] in
            self?.showResult(in: self!.navigationController, viewModel: viewModel)
            
        }).disposed(by: disposeBag)
        
        return Observable.never()
    }
    
    private func showResult(in navigationController: UINavigationController, viewModel: OrderViewModel) {
        let viewController = ResultViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

    
//    private func showResult(in navigationController: UINavigationController) {
//        navigationController.popToRootViewController(animated: true)
//        let newViewController = NewViewController()
//        navigationController.pushViewController(newViewController, animated: true)
//    }

}

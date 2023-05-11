//
//  HomeCoordinator.swift
//  e_commerce
//
//  Created by Nguyen Dang Trong Thai on 4/26/23.
//

import UIKit
import RxSwift

class HomeCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let viewModel = HomeViewModel()
        let viewController = HomeViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        
        viewController.viewModel = viewModel
        
        viewModel.idProduct.subscribe(onNext: { [weak self] data in
            self?.showDetail(id: data, in: navigationController)
            
        }).disposed(by: disposeBag)
        
        viewModel.navigateToCart.subscribe(onNext: { [weak self] in
            self?.showCart(in: navigationController)
        }).disposed(by: disposeBag)
        
        viewModel.navigateToHistory.subscribe(onNext: { [weak self] in
            self?.showHistory(in: navigationController)
        }).disposed(by: disposeBag)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return Observable.never()
    }
    
    private func showDetail(id: Int, in navigationController: UINavigationController) {
        let detailCoordinator = DetailCoordinator(navigationController: navigationController, id: id)
        coordinate(to: detailCoordinator)
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func showCart(in navigationController: UINavigationController) {
        let cartCoordinator = CartCoordinator(navigationController: navigationController)
        coordinate(to: cartCoordinator)
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func showHistory(in navigationController: UINavigationController) {
        let historyCoordinator = HistoryCoordinator(navigationController: navigationController)
        coordinate(to: historyCoordinator)
            .subscribe()
            .disposed(by: disposeBag)
    }
}

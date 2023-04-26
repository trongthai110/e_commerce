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
    
    var id: Int = 0
    
    override func start() -> Observable<Void> {
        let viewModel = HomeViewModel()
        let viewController = HomeViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        
        viewController.viewModel = viewModel
        
        viewModel.idProduct.subscribe(onNext: { [weak self] data in
            self?.showCalendar(id: data, in: navigationController)
            
        })
        .disposed(by: disposeBag)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return Observable.never()
    }
    
    private func showCalendar(id: Int, in navigationController: UINavigationController) {
        let viewModel = DetailViewModel(id: id)
        let detailViewController = DetailViewController(viewModel: viewModel, id: id)
        navigationController.pushViewController(detailViewController, animated: true)
    }
}

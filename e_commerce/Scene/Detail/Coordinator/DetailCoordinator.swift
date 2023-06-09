//
//  DetailCoordinator.swift
//  e_commerce
//
//  Created by Nguyen Dang Trong Thai on 4/26/23.
//

import UIKit
import RxSwift

class DetailCoordinator: BaseCoordinator<Void> {
    
    private let navigationController: UINavigationController
    private let id: Int
    init(navigationController: UINavigationController, id: Int) {
        self.navigationController = navigationController
        self.id = id
    }
    
    override func start() -> Observable<Void> {
        let viewModel = DetailViewModel(id: id)
        let viewController = DetailViewController(viewModel: viewModel, id: id)
        navigationController.pushViewController(viewController, animated: true)
        
        viewController.viewModel = viewModel
        
        return Observable.never()
    }
}

//
//  DetailCoordinator.swift
//  e_commerce
//
//  Created by Nguyen Dang Trong Thai on 4/26/23.
//

import UIKit
import RxSwift

class DetailCoordinator: BaseCoordinator<Void> {
    
    private let rootViewController: UIViewController
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        let viewModel = DetailViewModel(id: Int())
        let viewController = DetailViewController(viewModel: viewModel, id: Int())
        let navigationController = UINavigationController(rootViewController: viewController)
        
        viewController.viewModel = viewModel
        
        rootViewController.present(navigationController, animated: true)
        
        return Observable.never()
    }
}

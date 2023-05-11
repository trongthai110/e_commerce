//
//  HistoryCoordinator.swift
//  e_commerce
//
//  Created by Nguyen Dang Trong Thai on 5/4/23.
//

import UIKit
import RxSwift

class HistoryCoordinator: BaseCoordinator<Void> {
    
    private let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() -> Observable<Void> {
        let viewModel = HistoryViewModel()
        let viewController = HistoryViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
        
        viewController.viewModel = viewModel
        
        viewModel.navigateToHistoryDetail.subscribe(onNext: { [weak self] in
            self?.showResult(in: self!.navigationController)
            
        }).disposed(by: disposeBag)
        
        return Observable.never()
    }
    
    private func showResult(in navigationController: UINavigationController) {
        navigationController.popToRootViewController(animated: true)
    }
    
}

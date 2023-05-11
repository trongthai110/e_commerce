//
//  HistoryViewController.swift
//  e_commerce
//
//  Created by Nguyen Dang Trong Thai on 5/4/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class HistoryViewController: UIViewController {
    
    var tableView = UITableView(frame: UIScreen.main.bounds)
    private let disposeBag = DisposeBag()
    
    var viewModel: HistoryViewModel
    let screensize: CGRect = UIScreen.main.bounds
    
    init(viewModel: HistoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeUI()
        initializeSubscribers()
        
        
        //register cell
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        //delegate & datasouce
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func initializeUI() {
        viewModel.title.bind(to: navigationItem.rx.title).disposed(by: disposeBag)
        
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func initializeSubscribers() {
        viewModel.totalPrice.subscribe(onNext: { [weak self] data in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel.getProductOffline()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let data = viewModel.productResult[indexPath.row]
        
        cell.lblTitle.text = data.title
        cell.lblPrice.text = data.price.roundedString(decimalPlaces: 1)
        cell.lblRate.text = data.rate.toStarString()
        cell.lblTotal.text = data.quantity.thousandsSeparator()
        cell.lblCategories.text = data.category
        cell.imgProduct.downloaded(from: data.image, contentMode: .scaleAspectFit)
        
        cell.btnAddToCart.isHidden = true
        cell.lblCount.isHidden = true
        cell.btnPlus.isHidden = true
        cell.btnMinus.isHidden = true
        return cell
    }
}


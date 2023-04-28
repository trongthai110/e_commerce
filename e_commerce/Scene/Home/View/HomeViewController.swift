//
//  HomeViewController.swift
//  e_commerce
//
//  Created by Nguyen Dang Trong Thai on 4/26/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    var tableView = UITableView(frame: UIScreen.main.bounds)
    private let disposeBag = DisposeBag()
    
    var viewModel: HomeViewModel
    let screensize: CGRect = UIScreen.main.bounds
    var headerView = HeaderView()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let networkManager = NetworkManager()
    var apiResult = [ProductModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeUI()
        initializeSubscribers()
        
        
        //register cell
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        //delegate & datasouce
        tableView.delegate = self
        tableView.dataSource = self
        
        networkManager.getAllProduct { product, error in
            
            if let error = error {
                print(error)
                return
            }
            self.apiResult = product!
            self.tableView.reloadData()
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func initializeUI() {
        viewModel.title.bind(to: navigationItem.rx.title).disposed(by: disposeBag)

        tableView.backgroundColor = .white
        view.addSubview(headerView)
        view.addSubview(tableView)
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(tableView.snp.top).offset(0)
            make.height.equalTo(100)
        }
        
        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func initializeSubscribers() {
        headerView.btnGoToCart.rx.tap.bind(onNext: { [weak self] in
            self?.viewModel.cartTapped()
        }).disposed(by: disposeBag)
        
        
        viewModel.productQuantity
            .subscribe(onNext: { [weak self] data in
                self?.headerView.lblCounting.text = String(data)
            }).disposed(by: disposeBag)
        
        viewModel.getProductQuantity()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.lblTitle.text = apiResult[indexPath.row].title
        cell.lblPrice.text = apiResult[indexPath.row].price.roundedString(decimalPlaces: 1)
        cell.lblRate.text = apiResult[indexPath.row].rate.toStarString()
        cell.lblCount.text = apiResult[indexPath.row].count.thousandsSeparator()
        cell.lblCategories.text = apiResult[indexPath.row].category
        cell.imgProduct.downloaded(from: apiResult[indexPath.row].image, contentMode: .scaleAspectFit)
        
        cell.buttonAction = { [weak self] in
            self?.viewModel.addToCart(for: (self?.apiResult[indexPath.row])!)
        }
        
        cell.lblTotal.isHidden = true
        cell.btnPlus.isHidden = true
        cell.btnMinus.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.onTapped(id: apiResult[indexPath.row].id)
    }
}

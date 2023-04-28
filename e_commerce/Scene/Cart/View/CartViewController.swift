//
//  CartViewController.swift
//  e_commerce
//
//  Created by Nguyen Dang Trong Thai on 4/27/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class CartViewController: UIViewController {
    
    var tableView = UITableView(frame: UIScreen.main.bounds)
    private let disposeBag = DisposeBag()
    
    var viewModel: CartViewModel
    var footerView = FooterView()
    let screensize: CGRect = UIScreen.main.bounds
    
    init(viewModel: CartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var productResult = [ProductOffline]()
    
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

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func initializeUI() {
        viewModel.title.bind(to: navigationItem.rx.title).disposed(by: disposeBag)
        
        footerView.lblTotal.text = "Total"
        footerView.btnGoToCheckOut.setTitle("Checkout", for: .normal)
        
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(footerView)
        
        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(0)
        }
        
        footerView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(0)
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(150)
        }
    }
    
    func initializeSubscribers() {
        viewModel.productOffline.subscribe(onNext: { [weak self] data in
            self?.productResult.append(data)
        }).disposed(by: disposeBag)
        
        viewModel.totalPrice.subscribe(onNext: { [weak self] data in
            self?.footerView.lblPrice.text = String(data)
        }).disposed(by: disposeBag)
        
        viewModel.productTotal.subscribe(onNext: { [weak self] data in
            self?.tableView.reloadRows(at: data, with: .none)
        }).disposed(by: disposeBag)
        
        footerView.btnGoToCheckOut.rx.tap.bind(onNext: { [weak self] in
            self?.viewModel.checkoutTapped()
        }).disposed(by: disposeBag)
        
        viewModel.getProductOffline()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.lblTitle.text = productResult[indexPath.row].title
        cell.lblPrice.text = productResult[indexPath.row].price.roundedString(decimalPlaces: 1)
        cell.lblRate.text = productResult[indexPath.row].rate.toStarString()
        cell.lblTotal.text = productResult[indexPath.row].quantity.thousandsSeparator()
        cell.lblCategories.text = productResult[indexPath.row].category
        cell.imgProduct.downloaded(from: productResult[indexPath.row].image, contentMode: .scaleAspectFit)
        
        cell.plusAction = { [weak self] in
            self?.viewModel.handleProductOffline(for: (self?.productResult[indexPath.row])!, for: true, for: [indexPath])
        }
        
        cell.minusAction = { [weak self] in
            self?.viewModel.handleProductOffline(for: (self?.productResult[indexPath.row])!, for: false, for: [indexPath])
        }
        
        cell.btnAddToCart.isHidden = true
        cell.lblCount.isHidden = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

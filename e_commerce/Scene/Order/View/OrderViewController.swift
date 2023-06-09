//
//  OrderViewController.swift
//  e_commerce
//
//  Created by Nguyen Dang Trong Thai on 4/28/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class OrderViewController: UIViewController {
    
    var tableView = UITableView(frame: UIScreen.main.bounds)
    private let disposeBag = DisposeBag()
    
    var viewModel: OrderViewModel
    var footerView = FooterView()
    let screensize: CGRect = UIScreen.main.bounds
    
    init(viewModel: OrderViewModel) {
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

extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func initializeUI() {
        viewModel.title.bind(to: navigationItem.rx.title).disposed(by: disposeBag)
        
        footerView.lblPrivacy.text = "By pressing confirm order, you agree to our Terms and Privacy"
        footerView.lblPrivacy.numberOfLines = 0
        footerView.lblPrivacy.lineBreakMode = .byWordWrapping
        footerView.btnGoToCheckOut.setTitle("Confirm Order", for: .normal)
        
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
        viewModel.totalPrice.subscribe(onNext: { [weak self] data in
            self?.footerView.lblPrice.text = String(data)
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        footerView.btnGoToCheckOut.rx.tap.bind(onNext: { [weak self] in
            self?.viewModel.submitTapped()
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

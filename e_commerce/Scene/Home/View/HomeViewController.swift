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
    let btnGotoCart = UIBarButtonItem(image: UIImage(systemName: "cart.fill"), style: .done, target: nil, action: nil)
    let btnGotoHistory = UIBarButtonItem(image: UIImage(systemName: "clock.arrow.circlepath"), style: .plain, target: nil, action: nil)
    
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
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        label.text = "0"
        label.textColor = .red
        let lblCounting = UIBarButtonItem(customView: label)
        
        initializeUI()
        initializeSubscribers()
        
        //register cell
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        //delegate & datasouce
        tableView.delegate = self
        tableView.dataSource = self
        
        btnGotoCart.tintColor = .orange
        btnGotoHistory.tintColor = .orange
        self.navigationItem.rightBarButtonItems = [btnGotoCart, btnGotoHistory, lblCounting]
        self.navigationController?.navigationBar.tintColor = .orange
        
        networkManager.getAllProduct { product, error in
            
            if let error = error {
                print(error)
                return
            }
            self.apiResult = product!
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.productQuantity
            .subscribe(onNext: { [weak self] data in
                //self?.headerView.lblCounting.text = String(data)
            }).disposed(by: disposeBag)
        
        viewModel.getProductQuantity()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func initializeUI() {
        viewModel.title.bind(to: navigationItem.rx.title).disposed(by: disposeBag)
        
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func initializeSubscribers() {
        btnGotoCart.rx.tap.subscribe(onNext: {
            self.viewModel.cartTapped()
        }).disposed(by: disposeBag)
        
        btnGotoHistory.rx.tap.subscribe(onNext: {
            self.viewModel.historyTapped()
        }).disposed(by: disposeBag)
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

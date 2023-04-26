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
        
        
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func initializeSubscribers() {
        
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.onTapped(id: apiResult[indexPath.row].id)
        print("selected:", apiResult[indexPath.row].id)
    }
}

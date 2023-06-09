//
//  DetailViewController.swift
//  e_commerce
//
//  Created by Nguyen Dang Trong Thai on 4/26/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {
    
    var tableView = UITableView(frame: UIScreen.main.bounds)
    private let disposeBag = DisposeBag()
    
    var viewModel: DetailViewModel
    private let id: Int
    var footerView = FooterView()
    let screensize: CGRect = UIScreen.main.bounds
    
    init(viewModel: DetailViewModel, id: Int) {
        self.viewModel = viewModel
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let networkManager = NetworkManager()
    var apiResult: [ProductModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeUI()
        initializeSubscribers()
        
        
        //register cell
        tableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        //delegate & datasouce
        tableView.delegate = self
        tableView.dataSource = self
        
        networkManager.getProduct(id: id) { product, error in
            if let error = error {
                print(error)
                return
            }
            self.apiResult.append(product!)
            self.tableView.reloadData()
        }
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func initializeUI() {
        viewModel.title.bind(to: navigationItem.rx.title).disposed(by: disposeBag)
        
        footerView.btnGoToCheckOut.setTitle("Add to cart", for: .normal)
        
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
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailTableViewCell
        cell.imgProduct.downloaded(from: apiResult[indexPath.row].image, contentMode: .scaleAspectFit)
        cell.lblTitle.text = apiResult[indexPath.row].title
        cell.lblPrice.text = apiResult[indexPath.row].price.roundedString(decimalPlaces: 3)
        cell.lblDescription.text = apiResult[indexPath.row].description
        
        return cell
    }
}

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
    @IBOutlet weak var viewRating: RatingView!
    var tableView = UITableView(frame: UIScreen.main.bounds)
    private let disposeBag = DisposeBag()
    
    var viewModel: DetailViewModel
    private let id: Int
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailTableViewCell
        cell.imgProduct.downloaded(from: apiResult[indexPath.row].image, contentMode: .scaleAspectFit)
        cell.lblTitle.text = apiResult[indexPath.row].title
        cell.lblPrice.text = apiResult[indexPath.row].price.roundedString(decimalPlaces: 3)
        cell.lblDescription.text = apiResult[indexPath.row].description
        
        return cell
    }
}

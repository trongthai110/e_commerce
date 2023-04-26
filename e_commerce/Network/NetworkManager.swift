//
//  NetworkManager.swift
//  e_commerce
//
//  Created by Nguyen Dang Trong Thai on 4/26/23.
//

import Moya
import ObjectMapper
import RxSwift
import RxCocoa

protocol Networkable {
    var provider: MoyaProvider<APIService> { get }

    func getAllProduct(completion: @escaping ([ProductModel]?, Error?) -> ())
    func getProduct(id: Int, completion: @escaping (ProductModel?, Error?) -> ())

}

class NetworkManager: Networkable {

    //var provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
    var provider = MoyaProvider<APIService>()

    func getAllProduct(completion: @escaping ([ProductModel]?, Error?) -> ()) {
        provider.request(.getAllProduct) { result in
            switch result {
                case .failure(let error):
                    completion(nil, error)
                case .success(let value):
                    do {
                        let parsedData = try JSONSerialization.jsonObject(with: value.data as Data) as! [[String: Any]]
                        let product: [ProductModel] = Mapper<ProductModel>().mapArray(JSONArray: parsedData)
                        completion(product, nil)
                    } catch let error {
                        completion(nil, error)
                        print(error)
                    }
            }
        }
    }
    
    func getProduct(id: Int, completion: @escaping (ProductModel?, Error?) -> ()) {
        provider.request(.getProduct(id: id)) { result in
            switch result {
                case .failure(let error):
                    completion(nil, error)
                case .success(let value):
                    do {
                        let parsedData = try JSONSerialization.jsonObject(with: value.data as Data) as! [String: Any]
                        let product: ProductModel = Mapper<ProductModel>().map(JSONObject: parsedData)!
                        completion(product, nil)
                    } catch let error {
                        completion(nil, error)
                        print(error)
                    }
            }
        }
    }
}

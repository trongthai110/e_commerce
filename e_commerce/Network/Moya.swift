//
//  Moya.swift
//  e_commerce
//
//  Created by Nguyen Dang Trong Thai on 4/26/23.
//

import Moya

enum APIService {
    case getAllProduct
    case getProduct(id: Int)
}

extension APIService: TargetType{
    
    
    var baseURL: URL {
        return URL(string: "https://fakestoreapi.com")!
    }
    
    var path: String {
        switch self {
            case .getAllProduct:
                return "/products"
            case .getProduct(id: let id):
                return "/products/\(id)"
        }
    }
    
    var method: Method {
        switch self {
            case .getAllProduct:
                return .get
            case .getProduct:
                return .get
        }
    }
    
    var sampleData: Data {
        switch self {
            case .getAllProduct:
                return Data()
            case .getProduct:
                return Data()
        }
    }
    
    var task: Task {
        switch self {
            case let .getAllProduct:
                return .requestPlain
            case let .getProduct:
                return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}

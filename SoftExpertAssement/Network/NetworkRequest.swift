//
//  NetworkRequest.swift
//  SoftExpertAssement
//
//  Created by Rana on 2/15/21.
//

import Foundation
import Alamofire


class NetworkManager {

    static let shared = NetworkManager()

    private init() {}


    //MARK: -get all products
    func fetchAllProducts(url: String, completion: @escaping (_ products: SearchRecipeModel?, _ error: String?) -> Void) {
        AF.request(url, method: .get).responseDecodable(of: SearchRecipeModel.self) { response in
            switch response.result {
            case .success(let productsData):
                completion(productsData, nil)
            case .failure(let error):
                print("the error is \(error)")
                completion(nil, error.localizedDescription)
            }
        }
    }
}

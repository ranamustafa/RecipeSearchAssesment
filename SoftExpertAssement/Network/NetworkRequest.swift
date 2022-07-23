//
//  NetworkRequest.swift
//  OutDoorOrder
//
//  Created by Mac on 2/15/21.
//

import Foundation
import Alamofire
import PKHUD

class NetworkRequest{

    class func RequestByRawData(vc: UIViewController?, showLoading: Bool = true, url : String, method: HTTPMethod, parameters: [String : Any]?, headers: HTTPHeaders?, encoding: ParameterEncoding = JSONEncoding.default, completionHundler: @escaping (DataResponse<Any, AFError>? ,String?)->Void) {
        print ("url \(url)")
        print ("parameters \(parameters)")

        if showLoading {
            HUD.show(.progress, onView: vc?.view)
        }

        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON { (response:DataResponse) in
            HUD.hide()
            let temp = response.response?.statusCode ?? 400

            if temp >= 300 {
                print("temp \(temp)")
                completionHundler(nil, "\(temp)")
                return
            }

            print(temp)
            switch(response.result) {
            case .success(let value):
//                print("this is network request response data\(value)")
//                    print("this is network request number of bytes \(response.data!)")
                    completionHundler(response,nil)
            case .failure(_):
                let lockString = NSLocalizedString("Something went wrong please try again later", comment: "حدث خطأ برجاء اعادة المحاولة")
                print(lockString)
                print(response.error?.localizedDescription)
                completionHundler(nil,nil)
                break
            }
        }
    }
    class func RequestFromCell(vc: UITableViewCell?, showLoading: Bool = true, url : String, method: HTTPMethod, parameters: [String : Any]?, headers: HTTPHeaders?, encoding: ParameterEncoding = URLEncoding.default, completionHundler: @escaping (DataResponse<Any, AFError>? ,String?)->Void) {
        print ("url \(url)")
        print ("parameters \(parameters)")

        if showLoading {
            HUD.show(.progress, onView: vc?.contentView)
        }

        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON { (response:DataResponse) in
            HUD.hide()
            let temp = response.response?.statusCode ?? 400

            if temp >= 300 {
                print("temp \(temp)")
                completionHundler(nil, "\(temp)")
                return
            }

            print(temp)
            switch(response.result) {
            case .success(let value):
                print("this is network request response data\(value)")
                    print("this is network request number of bytes \(response.data!)")
                    completionHundler(response,nil)
            case .failure(_):
                let lockString = NSLocalizedString("Something went wrong please try again later", comment: "حدث خطأ برجاء اعادة المحاولة")
                print(lockString)
                print(response.error?.localizedDescription)
                completionHundler(nil,nil)
                break
            }
        }
    }
    class func Request(vc: UIViewController?, showLoading: Bool = true, url : String, method: HTTPMethod, parameters: [String : Any]?, headers: HTTPHeaders?, encoding: ParameterEncoding = URLEncoding.default, completionHundler: @escaping (DataResponse<Any, AFError>? ,String?)->Void) {
        print ("url \(url)")
        print ("parameters \(parameters)")

        if showLoading {
            HUD.show(.progress, onView: vc?.view)
        }

        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON { (response:DataResponse) in
            HUD.hide()
            let temp = response.response?.statusCode ?? 400

            if temp >= 300 {
                print("temp \(temp)")
                completionHundler(nil, "\(temp)")
                return
            }

            print(temp)
            switch(response.result) {
            case .success(let value):
//                print("this is network request response data\(value)")
//                    print("this is network request number of bytes \(response.data!)")
                    completionHundler(response,nil)
            case .failure(_):
                let lockString = NSLocalizedString("Something went wrong please try again later", comment: "حدث خطأ برجاء اعادة المحاولة")
                print(lockString)
                print(response.error?.localizedDescription)
                completionHundler(nil,nil)
                break
            }
        }
    }
}




//class NetworkManager {
//
//    static let shared = NetworkManager()
//
//    private init() {}
//
//
//    //MARK: -get all products
//    func fetchAllProducts(url: String, completion: @escaping (_ products: SearchRecipeModel?, _ error: String?) -> Void) {
//        AF.request(url, method: .get).responseDecodable(of: SearchRecipeModel.self) { response in
//            switch response.result {
//            case .success(let productsData):
//                completion(productsData, nil)
//            case .failure(let error):
//                print("the error is \(error)")
//                completion(nil, error.localizedDescription)
//            }
//        }
//    }
//}

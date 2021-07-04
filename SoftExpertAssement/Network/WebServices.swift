//
//  WebServices.swift
//  OutDoorOrder
//
//  Created by Mac on 2/15/21.
//

import Foundation
import Alamofire

class WebServices {

    // get method

    class func getRecipes(vc : UIViewController, showLoading: Bool, url: String, completionHundler: @escaping (SearchRecipeModel?,String?) -> Void){
        NetworkRequest.Request(vc: vc, showLoading: showLoading, url: url, method: .get, parameters: nil, headers: nil){
            response , error in
            if response == nil && error == nil{
                //No response and no error
                completionHundler(nil,nil)
            }else{
                // there are response but No error
                if error == nil{
                    do {
                        let ParsedResult = try JSONDecoder().decode(SearchRecipeModel?.self,from:(response?.data)!)
                        completionHundler(ParsedResult,nil)
                        print("sucess decoding")
                    }catch{
                        print("errorrrr catcchhchchchc")
                        print("error decoding")
                        print (error)
                    }
                }else{
                    print("error area busy in method")
                    completionHundler(nil, error)
                }
            }
        }
    }
//
//    // get Item Details
//    class func getItemDetails(vc : UIViewController, showLoading: Bool, url: String, completionHundler: @escaping (ItemModel?,String?) -> Void){
//        NetworkRequest.Request(vc: vc, showLoading: showLoading, url: url, method: .get, parameters: nil, headers: nil){
//            response , error in
//            if response == nil && error == nil{
//                //No response and no error
//                completionHundler(nil,nil)
//            }else{
//                // there are response but No error
//                if error == nil{
//                    do {
//                        let ParsedResult = try JSONDecoder().decode(ItemModel?.self,from:(response?.data)!)
//                        completionHundler(ParsedResult,nil)
//                        print("sucess decoding")
//                    }catch{
//                        print("errorrrr catcchhchchchc")
//                        print("error decoding")
//                        print (error)
//                    }
//                }else{
//                    print("error area busy in method")
//                    completionHundler(nil, error)
//                }
//            }
//        }
//    }
//
//
//    // post Method
//    class func getOptionVariant(vc : UITableViewCell, parameters: [String : Any], completionHundler: @escaping (GetVariantsModel?,String?) -> Void){
//
//        NetworkRequest.RequestFromCell(vc: vc, url: APIs.shared.getVariants(), method: .post, parameters: parameters, headers: nil){
//            response , error in
//            if response == nil && error == nil{
//                completionHundler(nil,nil)
//            }else{
//                if error == nil{
//                    do {
//                        let ParsedResult = try JSONDecoder().decode(GetVariantsModel?.self,from:(response?.data)!)
//                        completionHundler(ParsedResult,nil)
//                        print("sucess decoding and the parsed data is \(String(describing: ParsedResult))")
//                    }catch{
//                        print("errorrrr catcchhchchchc")
//                        print (error)
//                    }
//                }else{
//                    print("error area busy in method")
//                    completionHundler(nil, error)
//                }
//            }
//        }
//    }
//    class func getOptionVariantFromVC(vc : UIViewController, parameters: [String : Any], completionHundler: @escaping (GetVariantsModel?,String?) -> Void){
//
//        NetworkRequest.Request(vc: vc, url: APIs.shared.getVariants(), method: .post, parameters: parameters, headers: nil){
//            response , error in
//            if response == nil && error == nil{
//                completionHundler(nil,nil)
//            }else{
//                if error == nil{
//                    do {
//                        let ParsedResult = try JSONDecoder().decode(GetVariantsModel?.self,from:(response?.data)!)
//                        completionHundler(ParsedResult,nil)
//                        print("sucess decoding and the parsed data is \(String(describing: ParsedResult))")
//                    }catch{
//                        print("errorrrr catcchhchchchc")
//                        print (error)
//                    }
//                }else{
//                    print("error area busy in method")
//                    completionHundler(nil, error)
//                }
//            }
//        }
//    }
//    // post Method
//    class func postOrder(vc : UIViewController, parameters: [String : Any], completionHundler: @escaping (ConfirmOrderModel?,String?) -> Void){
//
//        NetworkRequest.RequestByRawData(vc: vc, url: APIs.shared.postOrder(), method: .post, parameters: parameters, headers: nil){
//            response , error in
//            if response == nil && error == nil{
//                completionHundler(nil,nil)
//            }else{
//                if error == nil{
//                    do {
//                        let ParsedResult = try JSONDecoder().decode(ConfirmOrderModel?.self,from:(response?.data)!)
//                        completionHundler(ParsedResult,nil)
//                        print("sucess decoding and the parsed data is \(String(describing: ParsedResult))")
//                    }catch{
//                        print("errorrrr catcchhchchchc")
//                        print (error)
//                    }
//                }else{
//                    print("error area busy in method")
//                    completionHundler(nil, error)
//                }
//            }
//        }
//    }
}

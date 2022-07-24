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
//                        print("Decodede response \(ParsedResult)")
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

}

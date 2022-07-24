//
//  APIs.swift
//  SoftExpertAssement
//
//  Created by Mac on 30/07/21.
//

import Foundation
import Alamofire

struct APIs {
    
    static let appID = "f243a7fe"
    static let appKey = "b6ca42762da36675a4e8652388af7b00"
    static let shared = APIs()
    private init() {}
    
    private let sharedAppInfo = "&app_id=\(APIs.appID)&app_key=\(APIs.appKey)"
    private let endPoint = "https://api.edamam.com/api/recipes/v2"
    
//    var headers: HTTPHeaders? {
//       return ["Authorization": User.shared.data?.data?.token ?? ""]
//    }
    func searchRecipesByWords(quary:String) -> String{
        return endPoint + "?type=public&q=\(quary)" + sharedAppInfo
    }
    func recipesDetails(id:String) -> String{
        return endPoint + "/\(id)?type=public" + sharedAppInfo
    }
    func searchRecipesByHealth(quary: String, health:String)-> String{
        return endPoint + "?type=public&q=\(quary)" + sharedAppInfo + "&health=\(health)"
    }
   
    
    
}

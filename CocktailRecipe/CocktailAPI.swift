//
//  CocktailAPI.swift
//  CocktailRecipe
//
//  Created by Masashi Hamano on 2017/01/27.
//  Copyright © 2017年 Marcy. All rights reserved.
//

import Foundation
import Alamofire
import Unbox

struct CocktailAPI{
    
    static let endpoint = "https://script.google.com/macros/s/AKfycbz54ZkXMpyZXd7gJG9THhBIatqiZyHQQNdPH3Ae8MkYCKbcdFc/exec"
    
    static func getCocktails(id: String, result:@escaping (_ result: Any,_ error: Error?) ->()){
        Alamofire.request(endpoint, parameters: ["id" : id]).responseJSON { response in
            result(response.result.value!,nil)
        }
    }
    static func postCocktails(upload : uploadCocktail) {
        let userDefault = UserDefaults.standard
        
//        let parameters: Parameters = [
//            "number": "10000",
//            "name": userDefault.string(forKey: "Name") ?? "Name",
//            "method": userDefault.string(forKey: "Method") ?? "Method",
//            "type": userDefault.string(forKey: "Type") ?? "Type",
//            "strength": userDefault.string(forKey: "Strength") ?? "Strength",
//            "taste": userDefault.string(forKey: "Taste") ?? "Taste",
//            "img_path": userDefault.string(forKey: "Image") ?? "No image"
//        ]

        let parameters: Parameters = [
            "number": "10000",
            "name": upload.name,
            "method": upload.method,
            "type": upload.type,
            "strength": upload.strength,
            "taste": upload.taste ?? "さっぱり",
            "img_path": upload.img_path
        ]
        
        //        Alamofire.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default)
        Alamofire.request(endpoint, method: .post, parameters: parameters)
            .responseString { response in
//                print(response.result)
            }
    }
}

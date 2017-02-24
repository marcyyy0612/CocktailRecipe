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
    
    //    static let endpoint = "https://script.google.com/macros/s/AKfycbz54ZkXMpyZXd7gJG9THhBIatqiZyHQQNdPH3Ae8MkYCKbcdFc/exec"
    static let endpoint = "https://script.google.com/macros/s/AKfycbwWp14fifzXgRX3hKqD93fnUOW3hRX_rDHjra3i-SmFijKcI58/exec"
    
    static func getCocktails(id: String, result:@escaping (_ result: Any,_ error: Error?) ->()){
        Alamofire.request(endpoint, parameters: ["id" : id]).responseJSON { response in
            result(response.result.value!,nil)
        }
    }
    static func postCocktails(upload : uploadCocktail, result:@escaping (_ result: Any,_ error: Error?) ->()) {
        
        let parameters: Parameters = [
            "number": upload.number,
            "name": upload.name ?? "No name",
            "method": upload.method,
            "type": upload.type,
            "strength": upload.strength,
            "taste": upload.taste ?? "さっぱり",
            "img_path": upload.img_path ?? "No Image",
            "comp": upload.comp
            ]
        
//        let parameters: Parameters = [
//            "number": "1",
//            "name": "No name",
//            "method": "shake",
//            "type": "long",
//            "strength": "strong",
//            "taste": "さっぱり",
//            "img_path": "no image",
//            "comp" : [
//                [
//                    "material" : "gin",
//                    "quantity" : "30ml"
//                ],
//                [
//                    "material" : "tonic",
//                    "quantity" : "any"
//                ]
//            ]
//        ]
        
//        print(upload.comp)
        Alamofire.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseString { response in
                print(response.result.value)
        }
    }
}

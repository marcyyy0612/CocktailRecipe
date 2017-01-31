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
}

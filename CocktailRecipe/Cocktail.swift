//
//  Cocktail.swift
//  CocktailRecipe
//
//  Created by MasashiHamano on 2016/12/22.
//  Copyright © 2016年 Marcy. All rights reserved.
//

import Foundation
import Unbox

struct Cocktail{
    var name: String
    var method: String
    var strength: String
    var taste: String
    var comp: [CocktailComp]
    var img_path: String
    var descript: String
}

struct CocktailComp {
    var material: String
    var quantity: String
}

extension Cocktail: Unboxable {
    init(unboxer: Unboxer) throws {
        self.name = try unboxer.unbox(key: "name")
        self.method = try unboxer.unbox(key: "method")
        self.strength = try unboxer.unbox(key: "strength")
        self.taste = try unboxer.unbox(key: "taste")
        self.comp = try unboxer.unbox(keyPath: "comp")
        self.img_path = try unboxer.unbox(key: "img_path")
        self.descript = ""
    }
}

extension CocktailComp: Unboxable {
    init(unboxer: Unboxer) throws {
        self.material = try unboxer.unbox(key: "material")
        self.quantity = try unboxer.unbox(key: "quantity")
    }
}

func fromJson(dictionary: UnboxableDictionary) throws -> Cocktail{
    var cocktail: Cocktail = try unbox(dictionary: dictionary)

    for value in cocktail.comp {
        cocktail.descript += value.material + ":" + value.quantity + ","
    }
    var endPoint = cocktail.descript.characters.count - 1
    cocktail.descript = (cocktail.descript as NSString).substring(to: endPoint)

    return cocktail
}

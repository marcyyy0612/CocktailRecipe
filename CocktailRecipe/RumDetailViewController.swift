//
//  RumDetailViewController.swift
//  CocktailRecipe
//
//  Created by Masashi Hamano on 2017/02/24.
//  Copyright © 2017年 Marcy. All rights reserved.
//

import Foundation
import XLPagerTabStrip

class RumDetailViewController: UIViewController {
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Rum")
    }
    
    @IBOutlet weak var CocktailName: UILabel!
    @IBOutlet weak var CocktailImage: UIImageView!
    @IBOutlet weak var CocktailMethod: UILabel!
    @IBOutlet weak var CocktailDetail: UILabel!
    
    var cocktail_name: String = ""
    var cocktail_image: String = ""
    var cocktail_method: String = ""
    var cocktail_comp = [CocktailComp]()
    var cocktail_detail: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.CocktailName.text = cocktail_name
        self.CocktailMethod.text = cocktail_method
        for value in cocktail_comp {
            cocktail_detail += value.material + " : " + value.quantity + "\n"
        }
        self.CocktailDetail.text = cocktail_detail
        CocktailDetail.sizeToFit()
        
        let decodeBase64 : NSData? =
            NSData(base64Encoded:
                cocktail_image, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
        
        //NSDataの生成が成功していたら
        if let decodeSuccess = decodeBase64 {
            //NSDataからUIImageを生成
            let img = UIImage(data: decodeSuccess as Data)
            self.CocktailImage.image = img
        } else {
            self.CocktailImage.image = UIImage(named: "noimage.png")
        }
        
    }
}

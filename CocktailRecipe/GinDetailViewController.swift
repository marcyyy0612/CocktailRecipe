//
//  GinDetailViewController.swift
//  CocktailRecipe
//
//  Created by Masashi Hamano on 2017/02/01.
//  Copyright © 2017年 Marcy. All rights reserved.
//

import Foundation
import XLPagerTabStrip

class GinDetailViewController: UIViewController {
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "GIN")
    }
    
    @IBOutlet weak var CocktailImage: UIImageView!
    @IBOutlet weak var CocktailName: UILabel!
    @IBOutlet weak var CocktailDetail: UILabel!
    
    var cocktail_name: String = ""
    var cocktail_image: String = ""
    
//    var cocktail_detail: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.CocktailName.text = cocktail_name
//        self.CocktailDetail.text = cocktail_detail
        
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

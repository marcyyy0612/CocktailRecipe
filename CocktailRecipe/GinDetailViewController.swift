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
//    var cocktail_detail: String = ""
//    var cocktail_image: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(cocktail_name)
        self.CocktailName.text = cocktail_name
//        self.CocktailDetail.text = cocktail_detail
    }
}

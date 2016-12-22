//
//  TequilaViewController.swift
//  CocktailRecipe
//
//  Created by MasashiHamano on 2016/07/08.
//  Copyright © 2016年 Marcy. All rights reserved.
//

import Foundation
import XLPagerTabStrip

class TequilaViewController: UIViewController, IndicatorInfoProvider {
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "TEQUILA")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tequilaベース"
        
        view.addSubview(label)
        view.backgroundColor = .white
        
        view.addConstraint(NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: -50))
    }

}

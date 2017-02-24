//
//  LoadingProxy.swift
//  CocktailRecipe
//
//  Created by Masashi Hamano on 2017/02/24.
//  Copyright © 2017年 Marcy. All rights reserved.
//

import UIKit

struct LoadingProxy{
    
    static var myActivityIndicator: UIActivityIndicatorView!
    
    static func set(v:UIViewController){
        self.myActivityIndicator = UIActivityIndicatorView()
        self.myActivityIndicator.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.myActivityIndicator.center = v.view.center
        self.myActivityIndicator.hidesWhenStopped = true
        self.myActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
//        self.myActivityIndicator.backgroundColor = UIColor.gray;
//        self.myActivityIndicator.layer.masksToBounds = true
//        self.myActivityIndicator.layer.cornerRadius = 5.0;
//        self.myActivityIndicator.layer.opacity = 0.8;
        v.view.addSubview(self.myActivityIndicator);
        
        self.off();
    }
    static func on(){
        myActivityIndicator.startAnimating();
//        myActivityIndicator.isHidden = false;
    }
    static func off(){
        myActivityIndicator.stopAnimating();
//        myActivityIndicator.isHidden = true;
    }
    
}

//
//  VodkaViewController.swift
//  CocktailRecipe
//
//  Created by MasashiHamano on 2016/07/08.
//  Copyright © 2016年 Marcy. All rights reserved.
//

import Foundation
import XLPagerTabStrip
import Alamofire
import Unbox

class VodkaViewController: UIViewController, IndicatorInfoProvider, UITableViewDataSource, UITableViewDelegate{
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "VODKA")
    }
    
    @IBOutlet weak var tableView: UITableView!
    var Cocktails:[Cocktail] = [Cocktail]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoadingProxy.set(v: self)
        LoadingProxy.on()
        updateData()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // XIBファイルからUINibのインスタンスを生成
        let nib = UINib(nibName: "CustomTableCell", bundle: nil)
        // UITableViewにXIBファイルを登録
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        
        view.backgroundColor = .white
        
    }
    
    func updateData(){
        CocktailAPI.getCocktails(id: "2"){(result, error) in
            if error == nil{
                LoadingProxy.off()
                self.setupCocktails(result: result as! NSArray)
                self.tableView.reloadData()
            }else{
                print("リクエストエラー")
            }
        }
    }
    
    func setupCocktails(result: NSArray) {
        for value in result {
            let cocktail:Cocktail = try! fromJson(dictionary: value as! UnboxableDictionary)
            Cocktails.append(cocktail)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cocktails.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? CustomTableCell
        
        //cell中身セット（引数　セル、indexPath）
        cell?.setCell(cocktail: Cocktails[indexPath.row])
        
        return cell!
    }
}

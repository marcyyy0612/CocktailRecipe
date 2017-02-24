//
//  GinViewController.swift
//  CocktailRecipe
//
//  Created by MasashiHamano on 2016/07/08.
//  Copyright © 2016年 Marcy. All rights reserved.
//

import Foundation
import XLPagerTabStrip
import Alamofire
import Unbox

class GinViewController: UIViewController, IndicatorInfoProvider, UITableViewDataSource, UITableViewDelegate{
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "GIN")
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
        CocktailAPI.getCocktails(id: "1"){(result, error) in
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
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "detail") as! GinDetailViewController
        
        nextView.cocktail_name = Cocktails[indexPath.row].name
        nextView.cocktail_image = Cocktails[indexPath.row].img_path
        
        self.navigationController?.pushViewController(nextView, animated: true)
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
    }
    
//    func showIndicator(){
//        //Indicatorを作成
//        ActivityIndicator = UIActivityIndicatorView()
//        ActivityIndicator.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
////        ActivityIndicator.backgroundColor = UIColor(red: 0/2555, green: 0/255, blue: 0/255, alpha: 0.7)
//        ActivityIndicator.layer.cornerRadius = 10
//        ActivityIndicator.center = self.view.center
//        
//        //Indicatorの状態を管理
//        ActivityIndicator.hidesWhenStopped = true
//        ActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
//        
//        //クルクルを開始
//        ActivityIndicator.startAnimating()
//        
//        //Viewに追加
//        self.view.addSubview(ActivityIndicator)
//    }
//    
//    //Indicatorを止めるときは、こちらを呼び出してあげます。
//    func hideIndicator(){
//        ActivityIndicator.stopAnimating()
//    }
    
}

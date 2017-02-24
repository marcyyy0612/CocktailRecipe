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
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoadingProxy.set(v: self)
        updateData()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // XIBファイルからUINibのインスタンスを生成
        let nib = UINib(nibName: "CustomTableCell", bundle: nil)
        // UITableViewにXIBファイルを登録
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        
        view.backgroundColor = .white
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(GinViewController.refresh(sender:)), for: .valueChanged)
    }
    
    func updateData(){
        LoadingProxy.on()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "detail") as! VodkaDetailViewController
        
        nextView.cocktail_name = Cocktails[indexPath.row].name
        nextView.cocktail_image = Cocktails[indexPath.row].img_path
        nextView.cocktail_comp = Cocktails[indexPath.row].comp
        
        self.navigationController?.pushViewController(nextView, animated: true)
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
    func refresh(sender: UIRefreshControl) {
        // ここに通信処理などデータフェッチの処理を書く
        // データフェッチが終わったらUIRefreshControl.endRefreshing()を呼ぶ必要がある
        Cocktails.removeAll()
        updateData()
        self.refreshControl.endRefreshing()
    }
}

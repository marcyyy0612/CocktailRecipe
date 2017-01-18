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

        Alamofire.request("https://script.google.com/macros/s/AKfycbz54ZkXMpyZXd7gJG9THhBIatqiZyHQQNdPH3Ae8MkYCKbcdFc/exec").responseJSON { response in
            var result = response.result.value
            print(result)
        }
        
        self.setupFriends()
        tableView.delegate = self
        tableView.dataSource = self
        
        // XIBファイルからUINibのインスタンスを生成
        let nib = UINib(nibName: "CustomTableCell", bundle: nil)
        // UITableViewにXIBファイルを登録
        tableView.register(nib, forCellReuseIdentifier: "Cell")

        view.backgroundColor = .white

    }
    
    func setupFriends() {
        let f1 = Cocktail(name: "Ken", descript:"kwen2ksfasdjfioasdfjioafd")
        Cocktails.append(f1)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cocktails.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? CustomTableCell
        
        //cell中身セット（引数　セル、indexPath）
        cell?.setCell(cocktail: Cocktails[indexPath.row])

        return cell!
    }
    
}

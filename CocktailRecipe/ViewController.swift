//
//  ViewController.swift
//  CocktailRecipe
//
//  Created by MasashiHamano on 2016/07/08.
//  Copyright © 2016年 Marcy. All rights reserved.
//

import Foundation
import XLPagerTabStrip

class ViewController: ButtonBarPagerTabStripViewController, UISearchBarDelegate{
    
    @IBOutlet weak var shadowView: UIView!
    
    var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        
        if let navigationBarFrame = navigationController?.navigationBar.bounds {
//            //ナビゲーションバーの背景を変更
            self.navigationController?.navigationBar.barTintColor = .black
//            //ナビゲーションのタイトル文字列の色を変更
//            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
            
            let searchBar: UISearchBar = UISearchBar(frame: navigationBarFrame)
            searchBar.delegate = self
            searchBar.showsCancelButton = true
            searchBar.keyboardAppearance = UIKeyboardAppearance.dark
            searchBar.keyboardType = UIKeyboardType.default
            navigationItem.titleView = searchBar
            navigationItem.titleView?.frame = searchBar.frame
            self.searchBar = searchBar
            searchBar.becomeFirstResponder()
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
        
        // change selected bar color
        settings.style.buttonBarBackgroundColor = .black
        settings.style.buttonBarItemBackgroundColor = .black
        settings.style.selectedBarBackgroundColor = .white
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 3.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .white
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
//        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
//            guard changeCurrentIndex == true else { return }
//            oldCell?.label.textColor = .gray
//            newCell?.label.textColor = .white
//        }
        super.viewDidLoad()
    }
    
    // MARK: - PagerTabStripDataSource
    
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let gin = UIStoryboard(name: "Gin", bundle: nil).instantiateInitialViewController() as! GinViewController
        let vodka = VodkaViewController()
        let tequila = TequilaViewController()
        let rum = RumViewController()
        let whiskey = WhiskeyViewController()
        let liquere = LiquereViewController()

        return [gin, vodka, tequila, rum, whiskey, liquere]
    }
    
    // MARK: - Custom Action
    
    // キーボードが表示を監視
    override func viewWillAppear(_ animated: Bool) {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(ViewController.handleKeyboardWillShowNotification(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    // キーボードが表示されるときにキャンセルボタンを有効に
    func handleKeyboardWillShowNotification(_ notification: Notification) {
        searchBar.showsCancelButton = true
    }
    
    // キャンセルボタンが押されたらキャンセルボタンを無効にしてフォーカスをはずす
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

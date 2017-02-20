//
//  RegistViewController.swift
//  uploadRecipe
//
//  Created by Masashi Hamano on 2017/02/09.
//  Copyright © 2017年 Marcy. All rights reserved.
//

import Foundation
import UIKit
import Eureka
import ImageRow

struct uploadCocktail {
    var number: String? = nil
    var name: String? = nil
    var method: String? = nil
    var type: String? = nil
    var strength: String? = nil
    var taste: String? = nil
    var base: String? = nil
    var img_path: String? = nil
}

class RegistViewController: FormViewController {

    let userDefault = UserDefaults.standard

    override func viewDidLoad() {
        var upload = uploadCocktail()

        super.viewDidLoad()
        form +++ Section("uploadInfo")
            <<< TextRow("Name"){ row in
                row.title = "カクテル名"
                row.placeholder = "Enter text here"
                }.onChange{row in
//                    self.userDefault.set(row.value, forKey: "Name")
                    upload.name = row.value!
            }
            
            <<< SegmentedRow<String>("Method") {
                $0.title = "製法"
                $0.options = ["ビルド","シェーク","ステア"]
//                $0.value = "ビルド"    // initially selected
                }.onChange{row in
//                    self.userDefault.set(row.value, forKey: "Method")
                    upload.method = row.value!
            }
            
            <<< SegmentedRow<String>("Type") {
                $0.title = "タイプ"
                $0.options = ["ロング","ショート","ロック"]
//                $0.value = "ロング"    // initially selected
                }.onChange{row in
//                    self.userDefault.set(row.value, forKey: "Type")
                    upload.type = row.value!
            }
            
            <<< SegmentedRow<String>("Strength") {
                $0.title = "強さ"
                $0.options = ["弱","中","強"]
//                $0.value = "弱"    // initially selected
                }.onChange{row in
//                    self.userDefault.set(row.value, forKey: "Strength")
                    upload.strength = row.value!
            }
            
            <<< PickerInlineRow<String>("Base") {
                $0.title = "Choose Base Alc"
                $0.options = ["Gin","Vodka","Tequila", "Rum", "Whiskey", "Liqure"]
//                $0.value = "Gin"    // initially selected
                }.onChange{row in
//                    self.userDefault.set(row.value, forKey: "Base")
                    upload.base = row.value!
            }
            
            
            <<< ImageRow() {
                $0.title = "ImageRow"
                $0.sourceTypes = .PhotoLibrary
                $0.clearAction = .no
                }
                .onChange {row in
//                    self.userDefault.set(UIImageJPEGRepresentation(row.value!, 0.8) as NSData?, forKey: "Image")
//                    upload.img_path = UIImageJPEGRepresentation(row.value!, 0.3) as NSData?
                    upload.img_path = (UIImageJPEGRepresentation(row.value!, 0.5) as NSData?)?.base64EncodedString()

//                    print(upload.img_path)
            }
            
            +++ Section("Material")
            <<< TextRow("Material") { row in
                row.title = "Material"
                row.placeholder = "name"
                }.onChange{row in
//                    self.userDefault.set(row.value, forKey: "Material")
            }
            <<< TextRow("Quantity") { row in
                row.title = "Quantity"
                row.placeholder = "ml"
                }.onChange{row in
//                    self.userDefault.set(row.value, forKey: "Quantity")
            }
        
            +++ Section("")
            <<< ButtonRow("Upload") {
                $0.title = "Upload"
                } .onCellSelection {  cell, row in  //do whatever you want
                    CocktailAPI.postCocktails(upload: upload)
        }

    }
}

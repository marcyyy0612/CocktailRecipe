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
    var number: String? = "1"
    var name: String?
    var method: String?
    var type: String?
    var strength: String?
    var taste: String?
    var img_path: String?
    var comp = [Any]()
}

class RegistViewController: FormViewController {
    
    override func viewDidLoad() {
//        LoadingProxy.set(v: self)
        var upload = uploadCocktail()
        var count = 0
        var strCount = 1
        var materialStr = "Material" + String(strCount)
        var quantityStr = "Quantity" + String(strCount)
        
        var tempComp = ["material": "", "quantity": ""]
        var tempMaterial = [String?]()
        var tempQuantity = [String?]()
        
        super.viewDidLoad()
        form +++ Section("uploadInfo")
            <<< TextRow("Name"){ row in
                row.title = "カクテル名"
                row.placeholder = "カクテル名入力"
                }.onChange{row in
                    upload.name = row.value
            }
            
            <<< SegmentedRow<String>("Method") {
                $0.title = "製法"
                $0.options = ["ビルド","シェーク","ステア"]
                //                $0.value = "ビルド"    // initially selected
                }.onChange{row in
                    upload.method = row.value!
            }
            
            <<< SegmentedRow<String>("Type") {
                $0.title = "タイプ"
                $0.options = ["ロング","ショート","ロック"]
                //                $0.value = "ロング"    // initially selected
                }.onChange{row in
                    upload.type = row.value!
            }
            
            <<< SegmentedRow<String>("Strength") {
                $0.title = "強さ"
                $0.options = ["弱","中","強"]
                //                $0.value = "弱"    // initially selected
                }.onChange{row in
                    upload.strength = row.value!
            }
            
            <<< PickerInlineRow<String>("Base") {
                $0.title = "ベース酒選択"
                $0.options = ["Gin","Vodka","Tequila", "Rum", "Whiskey", "Liquere"]
                $0.value = "Gin"    // initially selected
                }.onChange{row in
                    if(row.value! == "Gin") {
                        upload.number = "1"
                    } else if(row.value! == "Vodka") {
                        upload.number = "2"
                    } else if(row.value! == "Tequila") {
                        upload.number = "3"
                    } else if(row.value! == "Rum") {
                        upload.number = "4"
                    } else if(row.value! == "Whiskey") {
                        upload.number = "5"
                    } else if(row.value! == "Liquere") {
                        upload.number = "6"
                    }
            }
            
            
            <<< ImageRow() {
                $0.title = "写真選択"
                $0.sourceTypes = .PhotoLibrary
                $0.clearAction = .no
                }
                .onChange {row in
                    let upImg = row.value!
                    let resizedSize = CGSize(width: 100, height: 100)
                    UIGraphicsBeginImageContext(resizedSize);
                    upImg.draw(in: CGRect(x: 0, y: 0, width: 100, height: 100))
                    let resizedImage = UIGraphicsGetImageFromCurrentImageContext();
                    UIGraphicsEndImageContext();
                    
                    upload.img_path = (UIImageJPEGRepresentation(row.value!, 0.5) as NSData?)?.base64EncodedString()
                    
            }
            
            +++ Section("材料")
            <<< TextRow(materialStr) {
                $0.title = materialStr
                $0.placeholder = "材料名入力"
                tempMaterial.append("")
                }.onChange {row in
                    tempMaterial[count] = row.value
            }
            <<< TextRow(quantityStr) {
                $0.title = quantityStr
                $0.placeholder = "\"ml\" or \"dash\" or \"other\""
                tempQuantity.append("")
                }.onChange {row in
                    tempQuantity[count] = row.value
            }
            
            +++ Section("")
            <<< ButtonRow("AddMaterial") {
                $0.title = "材料追加"
                }.onCellSelection {_ in
                    count += 1
                    strCount += 1
                    materialStr = "Material" + String(strCount)
                    quantityStr = "Quantity" + String(strCount)
                    self.form[1]
                        <<< TextRow(materialStr) {
                            $0.title = materialStr
                            $0.placeholder = "材料名入力"
                            tempMaterial.append("")
                            }.onChange {row in
                                tempMaterial[count] = row.value
                        }
                        
                        <<< TextRow(quantityStr) {
                            $0.title = quantityStr
                            $0.placeholder = "\"ml\" or \"dash\" or \"other\""
                            tempQuantity.append("")
                            }.onChange {row in
                                tempQuantity[count] = row.value
                    }
            }
            
            +++ Section("")
            <<< ButtonRow("Upload") {
                $0.title = "Upload"
                } .onCellSelection {_ in  //do whatever you want
//                    LoadingProxy.on()
                    for i in 0..<tempMaterial.count {
                        tempComp["material"] = tempMaterial[i]
                        tempComp["quantity"] = tempQuantity[i]
                        upload.comp.append(tempComp)
                    }
                    //保存前アラート表示
                    let alert: UIAlertController = UIAlertController(title: "新しいカクテル", message: "保存しますか？", preferredStyle:  UIAlertControllerStyle.actionSheet)
                    let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
                        (action: UIAlertAction!) -> Void in
                        CocktailAPI.postCocktails(upload: upload){(result, error) in //post newカクテル
                            if error == nil{
                                self.navigationController?.popViewController(animated: true)
                                //   LoadingProxy.off()
                            }else{
                                print("リクエストエラー")
                            }
                        }
                    })
                    let cancelAction: UIAlertAction = UIAlertAction(title: "CANCEL", style: UIAlertActionStyle.cancel, handler:{
                        (action: UIAlertAction!) -> Void in
                    })
                    
                    alert.addAction(cancelAction)
                    alert.addAction(defaultAction)
                    self.present(alert, animated: true, completion: nil)

        }
    }//end viewDidLoad()
}

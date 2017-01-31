//
//  CustomTableCell.swift
//  CocktailRecipe
//
//  Created by MasashiHamano on 2016/12/22.
//  Copyright © 2016年 Marcy. All rights reserved.
//

import UIKit

class CustomTableCell: UITableViewCell {

    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Descript: UILabel!
    @IBOutlet weak var CocktailImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(cocktail :Cocktail) {
        self.Name.text = cocktail.name
        self.Descript.text = cocktail.descript
        self.CocktailImage.image = UIImage(named: "noimage.png")
    }}

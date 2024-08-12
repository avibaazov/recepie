//
//  IngredientPresentCell.swift
//  recepie
//
//  Created by Student15 on 12/08/2024.
//

import UIKit

class IngredientPresentCell: UITableViewCell {

    static let identifier = "IngredientPresentCell"
    
    @IBOutlet private weak var itemName: UILabel!
    
    func configureForPresent(ingredient: Ingredient?) {
        guard let name = ingredient?.name else {return}
        itemName.text =  "●  \(name)"
    }
    
    
}

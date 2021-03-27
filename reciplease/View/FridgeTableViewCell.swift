//
//  FridgeTableViewCell.swift
//  reciplease
//
//  Created by Mosma on 27/03/2021.
//

import UIKit

final class FridgeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ingredientLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(withIngredient ingredient: String) {
        ingredientLabel?.text = "- " + ingredient.localizedCapitalized
    }
}

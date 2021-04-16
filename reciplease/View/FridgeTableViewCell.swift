//
//  FridgeTableViewCell.swift
//  reciplease
//
//  Created by Mosma on 27/03/2021.
//

import UIKit

final class FridgeTableViewCell: UITableViewCell {
    
    // MARK: - Internal method
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// Used to add a dash before the name of the ingredients
    func configure(withIngredient ingredient: String) {
        ingredientLabel?.text = "- " + ingredient.localizedCapitalized
    }
    
    // MARK: - Outlet
    @IBOutlet private weak var ingredientLabel: UILabel!
}

//
//  RecipesTableViewCell.swift
//  reciplease
//
//  Created by Mosma on 19/03/2021.
//

import UIKit

class RecipesTableViewCell: UITableViewCell {
    
    // MARK: - Internal method
    
    /// Used to modify the cell based on the recipe information
    func configure(recipe: Recipe) {
        recipeImage.kf.setImage(with: URL(string: recipe.image))
        recipeTitle.text = recipe.label
        ingredientTitle.text = recipe.ingredientLines.joined(separator: ", ")
        timeLabel.text = recipe.totalTime.convertTimeToString
    }
    
    @IBOutlet private weak var recipeImage: UIImageView!
    @IBOutlet private weak var recipeTitle: UILabel!
    @IBOutlet private weak var ingredientTitle: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var gradientView: UIView!
}

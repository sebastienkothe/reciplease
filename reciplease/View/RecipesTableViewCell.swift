//
//  RecipesTableViewCell.swift
//  reciplease
//
//  Created by Mosma on 19/03/2021.
//

import UIKit

class RecipesTableViewCell: UITableViewCell {
    
    func configure(recipe: Recipe) {
        recipeImage.kf.setImage(with: URL(string: recipe.image))
        recipeTitle.text = recipe.label
        ingredientTitle.text = recipe.ingredientLines.joined(separator: ", ")
        timeLabel.text = recipe.totalTime.convertTimeToString
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var ingredientTitle: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
}

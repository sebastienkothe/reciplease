//
//  RecipesTableViewCell.swift
//  reciplease
//
//  Created by Mosma on 19/03/2021.
//

import UIKit

class RecipesTableViewCell: UITableViewCell {
    
    func configure(recipe: Recipe) {
        let imageUrlForRecipe = recipe.image
        recipeImage.kf.setImage(with: URL(string: imageUrlForRecipe))
        recipeTitle.text = recipe.label
        ingredientTitle.text = recipe.ingredientLines.joined(separator: ", ")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds
    }
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var ingredientTitle: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var recipeInformationView: UIView!
    
    private let gradient: CAGradientLayer = CAGradientLayer()
    
    private func addAGradientToLayer(frame: CGRect) -> CAGradientLayer {
        let clearColor = UIColor.clear.cgColor
        let blackColor = UIColor.black.cgColor
        gradient.frame = frame
        //layer.locations = [0, 0.9]
        gradient.startPoint = CGPoint(x: 0, y: 0.1)
        gradient.endPoint = CGPoint(x: 0, y: 0.8)
        gradient.colors = [clearColor, blackColor]
        return gradient
    }
}

//
//  RecipesTableViewCell.swift
//  reciplease
//
//  Created by Mosma on 19/03/2021.
//

import UIKit

class RecipesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var ingredientTitle: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var gradientView: UIView!
    
    let gradient: CAGradientLayer = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = gradientView.bounds
    }
    
    func configure(recipe: Recipe) {
        recipeImage.kf.setImage(with: URL(string: recipe.image))
        recipeTitle.text = recipe.label
        ingredientTitle.text = recipe.ingredientLines.joined(separator: ", ")
        timeLabel.text = recipe.totalTime.convertTimeToString
    }
        
    private func addAGradientToLayer() {
        let clearColor = UIColor.clear.cgColor
        let blackColor = UIColor.black.cgColor
        gradient.frame = gradientView.bounds
        //layer.locations = [0, 0.9]
        gradient.startPoint = CGPoint(x: 0, y: 0.1)
        gradient.endPoint = CGPoint(x: 0, y: 0.8)
        gradient.colors = [clearColor, blackColor]
        gradientView.layer.insertSublayer(gradient, at: 0)
    }
}

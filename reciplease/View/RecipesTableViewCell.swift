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
    
    var gradientLayer: CAGradientLayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addAGradientToLayer()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = gradientView.frame
    }
    
    func configure(recipe: Recipe) {
        recipeImage.kf.setImage(with: URL(string: recipe.image))
        recipeTitle.text = recipe.label
        ingredientTitle.text = recipe.ingredientLines.joined(separator: ", ")
        timeLabel.text = recipe.totalTime.convertTimeToString
    }
    
    private func addAGradientToLayer() {
        gradientLayer = CAGradientLayer()
        
        gradientLayer?.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer?.startPoint = CGPoint(x: 0, y: 0.1)
        gradientLayer?.endPoint = CGPoint(x: 0, y: 0.8)
        
        if let gradientLayer = gradientLayer {
            gradientView.layer.insertSublayer(gradientLayer, at: 3)
        }
    }
}

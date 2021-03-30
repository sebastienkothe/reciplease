//
//  RecipeDetailsViewController.swift
//  reciplease
//
//  Created by Mosma on 05/03/2021.
//

import UIKit
import Kingfisher

class RecipeDetailsViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var detailsRecipeTextView: UITextView!
    @IBOutlet private weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeInformationView: UIView!
    @IBOutlet weak var getDirectionsButton: UIButton!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var recipeTitle: UILabel!
    
    // MARK: - Properties
    var recipe: Recipe?
    private var coreDataManager: CoreDataManager?
    private var recipeIsFavorite = false
    
    // MARK: - Actions
    @IBAction func didTapOnFavoriteButton(_ sender: Any) {
    }
    
    @IBAction func didTapOnGetDirectionsButton(_ sender: Any) {
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpRecipe()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func coreDataFunction() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coreDataStack = appDelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }
    
    private func setUpRecipe() {
        guard let ingredientLines = recipe?.ingredientLines.joined(separator: "\n" + "- ") else { return }
        guard let yield = recipe?.yield else { return }
        guard let imageUrl = recipe?.image else { return }
        let totalTimeInt = recipe?.totalTime ?? 0
        
        detailsRecipeTextView.text = "- " + ingredientLines
        recipeTitle.text = recipe?.label.localizedCapitalized
        yieldLabel.text = String(yield)
        recipeImageView.kf.setImage(with: URL(string: imageUrl))
        timeLabel.text = totalTimeInt.convertTimeToString
    }
}

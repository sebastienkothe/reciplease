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
    var recipeEntity: RecipeEntity?
    private var coreDataManager: CoreDataManager?
    private var recipeIsFavorite = false
    private var isFavoriteNavigation: Bool = false
    
    // MARK: - Actions
    @IBAction func didTapOnFavoriteButton(_ sender: Any) {
        checkIfRecipeIsFavorite()
        !recipeIsFavorite ? addRecipeToFavorites() : deleteRecipeFavorite(recipeTitle: recipe?.label,
                                                                          url: recipe?.url,
                                                                          coreDataManager: coreDataManager,
                                                                          barButtonItem: favoriteButton)
    }
    
    @IBAction func didTapOnGetDirectionsButton(_ sender: Any) {
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataFunction()
        
        checkIfRecipeIsFavorite()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let controllersInStack = navigationController?.viewControllers else { return }
        print(controllersInStack.count)
        isFavoriteNavigation = controllersInStack.count == 2 ? true : false
        isFavoriteNavigation ? setUpFavoriteRecipe() : setUpRecipe()
        checkIfRecipeIsFavorite()
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
    
    private func setUpFavoriteRecipe() {
        recipeTitle.text = recipeEntity?.title
        detailsRecipeTextView.text = recipeEntity?.ingredients
        yieldLabel.text = String(recipeEntity?.yield ?? 0)
        timeLabel.text = Int(recipeEntity?.totalTime ?? 0).convertTimeToString
        guard let recipeUrl = recipeEntity?.image else { return }
        recipeImageView.kf.setImage(with: URL(string: recipeUrl))
    }
    
    private func checkIfRecipeIsFavorite() {
        guard let recipeTitle = recipeEntity?.title else { return }
        guard let url = recipeEntity?.url else { return }
        guard let checkIsRecipeIsFavorite = coreDataManager?.checkIfRecipeIsFavorite(recipeTitle: recipeTitle, url: url) else { return }
        
        recipeIsFavorite = checkIsRecipeIsFavorite
        
        if recipeIsFavorite {
            favoriteButton.tintColor = UIColor.green
        } else {
            favoriteButton.tintColor = .none
        }
    }
    
    private func addRecipeToFavorites() {
        guard let label = recipe?.label else { return }
        guard let ingredients = recipe?.ingredientLines.joined(separator: "\n" + "- ") else { return }
        guard let yield = recipe?.yield else { return }
        let totalTime = Int16(recipe?.totalTime ?? 0)
        guard let image = recipe?.image else { return }
        guard let url = recipe?.url else { return }
        
        coreDataManager?.createRecipe(title: label.localizedCapitalized,
                                      ingredients: "- " + ingredients,
                                      yield: Int16(yield),
                                      totalTime: totalTime,
                                      image: image, url: url)
        setupBarButtonItem(color: .green, barButtonItem: favoriteButton)
    }
}

//
//  RecipeDetailsViewController.swift
//  reciplease
//
//  Created by Mosma on 05/03/2021.
//

import UIKit
import Kingfisher

class RecipeDetailsViewController: BaseViewController {
    
    // MARK: - Internal Properties
    var recipe: Recipe?
    
    // MARK: - Internal Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataFunction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpRecipe()
        checkIfRecipeIsFavorite()
    }
    
    // MARK: - Outlets
    @IBOutlet private weak var detailsRecipeTextView: UITextView!
    @IBOutlet private weak var recipeImageView: UIImageView!
    @IBOutlet private weak var recipeInformationView: UIView!
    @IBOutlet private weak var getDirectionsButton: UIButton!
    @IBOutlet private weak var favoriteButton: UIBarButtonItem!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var yieldLabel: UILabel!
    @IBOutlet private weak var recipeTitle: UILabel!
    
    // MARK: - Actions
    @IBAction private func didTapOnFavoriteButton(_ sender: Any) {
        checkIfRecipeIsFavorite()
        if !recipeIsFavorite {
            addRecipeToFavorites()
        } else {
            deleteRecipeFavorite(recipeTitle: recipe?.label,
                                 url: recipe?.url,
                                 coreDataManager: coreDataManager,
                                 barButtonItem: favoriteButton)
        }
    }
    
    @IBAction private func didTapOnGetDirectionsButton(_ sender: Any) {
        guard let recipeUrl = recipe?.url else { return }
        goToTheRecipeWebsite(urlString: recipeUrl)
    }
    
    // MARK: - Private properties
    private var coreDataManager: CoreDataManager?
    private var recipeIsFavorite = false
    
    // MARK: - Private methods
    private func deleteRecipeFavorite(
        recipeTitle: String?,
        url: String?,
        coreDataManager: CoreDataManager?,
        barButtonItem: UIBarButtonItem
    ) {
        guard
            let coreDataManager = coreDataManager,
            let recipe = recipe
        else { return }
        
        coreDataManager.deleteRecipe(recipe: recipe)
        setupBarButtonItem(color: .white, barButtonItem: barButtonItem)
    }
    
    /// Used to set the value of the coreDataManager property
    private func coreDataFunction() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coreDataStack = appDelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }
    
    /// Used to open the mobile browser based on the URL provided by the recipe
    private func goToTheRecipeWebsite(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        guard UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    
    private func setupBarButtonItem(color: UIColor, barButtonItem: UIBarButtonItem) {
        barButtonItem.tintColor = color
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    /// Used to modify the interface based on the recipe information
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
    
    private func checkIfRecipeIsFavorite() {
        guard let recipe = recipe else { return }
        
        guard let checkIsRecipeIsFavorite = coreDataManager?.checkIfRecipeIsFavorite(
            recipeTitle: recipe.label,
            url: recipe.url
        ) else { return }
        
        recipeIsFavorite = checkIsRecipeIsFavorite
        
        if recipeIsFavorite {
            favoriteButton.tintColor = UIColor.green
        } else {
            favoriteButton.tintColor = .none
        }
    }
    
    private func addRecipeToFavorites() {
        guard let recipe = recipe else { return }

        let label = recipe.label
        let ingredients = recipe.ingredientLines.joined(separator: "\n" + "- ")
        let yield = recipe.yield
        let totalTime = Int16(recipe.totalTime)
        let image = recipe.image
        let url = recipe.url
        
        coreDataManager?.createRecipe(title: label.localizedCapitalized,
                                      ingredients: ingredients,
                                      yield: Int16(yield),
                                      totalTime: totalTime,
                                      image: image, url: url)
        setupBarButtonItem(color: .green, barButtonItem: favoriteButton)
    }
}

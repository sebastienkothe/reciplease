//
//  FridgeViewController.swift
//  reciplease
//
//  Created by Mosma on 05/03/2021.
//

import UIKit

class FridgeViewController: BaseViewController {
    
    // MARK: - Internal Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fridgeManager.delegate = self
        
        let nib = UINib(nibName: .fridgeTableViewCell, bundle: nil)
        ingredientsTableView.register(nib, forCellReuseIdentifier: .fridgeCell)
    }
    
    // MARK: - Outlets
    @IBOutlet private weak var ingredientTextField: UITextField!
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var clearButton: UIButton!
    @IBOutlet private weak var ingredientsTableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Actions
    @IBAction private func didTapOnAddIngredientButton() {
        
        guard let ingredientText = ingredientTextField.text else { return }
        
        switch fridgeManager.addIngredient(ingredient: ingredientText) {
        case .failure:
            handleError(.valueAlreadyExists)
        case .success: break
        }
        
        ingredientTextField.text = ""
    }
    
    @IBAction private func didTapOnClearButton(_ sender: Any) {
        fridgeManager.clearFridge()
    }
    
    @IBAction private func didTapOnSearchForRecipesButton() {
        // To show the activity  indicator and hide the button
        toggleActivityIndicator(shown: true, activityIndicator: activityIndicator, button: searchButton)
        searchForRecipes()
    }
    
    // MARK: - Properties
    private let fridgeManager = FridgeManager()
    
    // MARK: - Private methods
    private func searchForRecipes() {
        let recipeService = RecipeService()
        
        recipeService.fetchRecipesFrom(fridgeManager.ingredients) { [weak self] (result) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {


                self.toggleActivityIndicator(
                    shown: false,
                    activityIndicator: self.activityIndicator,
                    button: self.searchButton
                )
                
                switch result {
                case .failure:
                    self.handleError(.noRecipe)
                case .success(let recipes):
                    self.performSegue(withIdentifier: .segueGoToRecipesList, sender: recipes)
                }
            }
        }
    }
    
    private func handleError(_ error: Error) {
        var title: String
        var message: String
        
        switch error {
        case .valueAlreadyExists:
            title = "Ingredient is already in"
            message = "This ingredient already exists in your list."
        case .emptyArray:
            title = "No ingredient"
            message = "Please add an ingredient."
        case .noRecipe:
            title = "No recipe"
            message = "Sorry there is no recipe."
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

extension FridgeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fridgeManager.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: .fridgeCell, for: indexPath) as? FridgeTableViewCell else { return UITableViewCell() }
        
        cell.configure(withIngredient: fridgeManager.ingredients[indexPath.row])
        return cell
    }
    
}

extension FridgeViewController: UITableViewDelegate {}

extension FridgeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if
            let destinationViewController = segue.destination as? RecipesViewController,
            let recipes = sender as? [Recipe]
        {
            destinationViewController.recipes = recipes
            destinationViewController.shouldPresentFavorites = false
        }
    }
}

// MARK: - Keyboard
extension FridgeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == ingredientTextField {
            
            // Used to dismiss your keyboard
            textField.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        ingredientTextField.resignFirstResponder()
    }
    
}

extension FridgeViewController: FridgeManagerDelegate {
    func didChangeIngredients() {
        ingredientsTableView.reloadData()
    }
}


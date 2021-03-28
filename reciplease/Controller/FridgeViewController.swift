//
//  FridgeViewController.swift
//  reciplease
//
//  Created by Mosma on 05/03/2021.
//

import UIKit

class FridgeViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var ingredientTextField: UITextField!
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var clearButton: UIButton!
    @IBOutlet private weak var ingredientsTableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    private var ingredients: [String] = [] {
        didSet {
            ingredientsTableView.reloadData()
        }
    }
    
    // MARK: - Actions
    @IBAction private func didTapOnAddIngredientButton() {
        guard let ingredient = ingredientTextField.text?.trimmingCharacters(in: .whitespaces) else { return }
        
        for ingredientFromIngredientsArray in ingredients {
            guard ingredient.lowercased() != ingredientFromIngredientsArray.lowercased() else {
                handleError(.valueAlreadyExists)
                return
            }
        }
        
        ingredients.append(ingredient)
        ingredientTextField.text = String()
    }
    
    @IBAction private func didTapOnClearButton(_ sender: Any) {
        ingredients.removeAll()
    }
    
    @IBAction private func didTapOnSearchForRecipesButton() {
        // To show the activity  indicator and hide the button
        toggleActivityIndicator(shown: true, activityIndicator: activityIndicator, button: searchButton)
        searchForRecipes()
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: .fridgeTableViewCell, bundle: nil)
        ingredientsTableView.register(nib, forCellReuseIdentifier: .fridgeCell)
    }
    
    private func searchForRecipes() {
        let recipeService = RecipeService()
        
        recipeService.fetchRecipesFrom(ingredients) { [weak self] (success, recipeResponse) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.toggleActivityIndicator(shown: false, activityIndicator: self.activityIndicator, button: self.searchButton)
                if success {
                    let recipes = recipeResponse?.hits.map { $0.recipe }
                    self.performSegue(withIdentifier: .segueGoToRecipesList, sender: recipes)
                } else {
                    self.handleError(.noRecipe)
                }
            }
        }
    }
    
}

extension FridgeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: .fridgeCell, for: indexPath) as? FridgeTableViewCell else { return UITableViewCell() }
        
        cell.configure(withIngredient: ingredients[indexPath.row])
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
        }
    }
}

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



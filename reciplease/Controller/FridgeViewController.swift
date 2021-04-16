//
//  FridgeViewController.swift
//  reciplease
//
//  Created by Mosma on 05/03/2021.
//

import UIKit

class FridgeViewController: BaseViewController {
    
    // MARK: - Internal method
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
        case .failure(let error):
            errorAlertManager.presentErrorAsAlert(on: self, error: error)
        case .success:
            ingredientTextField.text = ""
        }
    }
    
    @IBAction private func didTapOnClearButton(_ sender: Any) {
        fridgeManager.clearFridge()
    }
    
    @IBAction private func didTapOnSearchForRecipesButton() {
        // To show the activity  indicator and hide the button
        handleActivityIndicator(shown: true, activityIndicator: activityIndicator, button: searchButton)
        searchForRecipes()
    }
    
    // MARK: - Private properties
    private let fridgeManager = FridgeManager()
    private let recipeService = RecipeService()
    
    // MARK: - Private method
    
    /// Used to initiate the process of collecting recipes
    private func searchForRecipes() {
        
        recipeService.fetchRecipesFrom(fridgeManager.ingredients) { [weak self] (result) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                
                
                self.handleActivityIndicator(
                    shown: false,
                    activityIndicator: self.activityIndicator,
                    button: self.searchButton
                )
                
                switch result {
                case .failure(let error):
                    self.errorAlertManager.presentErrorAsAlert(on: self, error: error)
                    
                case .success(let recipes):
                    self.performSegue(withIdentifier: .segueGoToRecipesList, sender: recipes)
                }
            }
        }
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


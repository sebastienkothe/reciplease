//
//  FridgeViewController.swift
//  reciplease
//
//  Created by Mosma on 05/03/2021.
//

import UIKit

protocol FridgeManagerDelegate: class {
    func didChangeIngredients()
}

enum FridgeManagerError: Error {
    case ingredientAlreadyExist
}

class FridgeManager {
    
    weak var delegate: FridgeManagerDelegate?
    
    var ingredients: [String] = [] {
        didSet {
            delegate?.didChangeIngredients()
        }
    }
    
    func addIngredient(ingredient: String) -> Result<Void, FridgeManagerError>  {
        let trimmedIngredient = ingredient.trimmingCharacters(in: .whitespaces)
        
        if ingredients.contains(where: { $0.lowercased() == trimmedIngredient.lowercased() }) {
            return .failure(.ingredientAlreadyExist)
        }
    
        ingredients.append(ingredient)
        return .success(())
    }
    
    func clearFridge() {
        ingredients.removeAll()
    }
}

class FridgeViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var ingredientTextField: UITextField!
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var clearButton: UIButton!
    @IBOutlet private weak var ingredientsTableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    
    private let fridgeManager = FridgeManager()
    
    // MARK: - Properties
    
    
    
    
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
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fridgeManager.delegate = self
        
        let nib = UINib(nibName: .fridgeTableViewCell, bundle: nil)
        ingredientsTableView.register(nib, forCellReuseIdentifier: .fridgeCell)
    }
    
    private func searchForRecipes() {
        let recipeService = RecipeService()
        
        recipeService.fetchRecipesFrom(fridgeManager.ingredients) { [weak self] (success, recipeResponse) in
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


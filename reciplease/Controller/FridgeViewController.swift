//
//  FridgeViewController.swift
//  reciplease
//
//  Created by Mosma on 05/03/2021.
//

import UIKit

class FridgeViewController: BaseViewController {
    
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var clearButton: UIButton!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    var ingredients: [String] = [] {
        didSet {
            ingredientsTableView.reloadData()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: .fridgeTableViewCell, bundle: nil)
        ingredientsTableView.register(nib, forCellReuseIdentifier: .fridgeCell)
    }
    
    @IBAction func didTapOnAddIngredientButton() {
        guard let ingredient = ingredientTextField.text?.trimmingCharacters(in: .whitespaces) else { return }
        
        for ingredientFromIngredientsArray in ingredients {
            guard ingredient.lowercased() != ingredientFromIngredientsArray.lowercased() else {
                handleError(error: .valueAlreadyExists)
                return
            }
        }
        
        ingredients.append(ingredient)
        //ingredientsTableView.reloadData()
        ingredientTextField.text = String()
    }
    
    @IBAction func didTapOnClearButton(_ sender: Any) {
        ingredients.removeAll()
    }
    
    @IBAction func didTapOnSearchForRecipesButton() {
        // To show the activity  indicator and hide the button
        toggleActivityIndicator(shown: true, activityIndicator: activityIndicator, button: searchButton)
        searchForRecipes()
    }
    
    
    @objc func onNotification(_ notification: Notification) {
        ingredientsTableView.reloadData()
    }
    
    func searchForRecipes() {
        let recipeNetworkManager = RecipeNetworkManager()
        
        recipeNetworkManager.fetchRecipesFrom(ingredients, completion: { [weak self] (result) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.toggleActivityIndicator(shown: false, activityIndicator: self.activityIndicator, button: self.searchButton)
                switch result {
                case .success(let recipeResponse):
                    let recipes = recipeResponse.hits.map { $0.recipe }
                    self.performSegue(withIdentifier: "goToRecipeList", sender: recipes)
                    
                case .failure(let error):
                    self.handleError(error: error)
                }
            }
        })
        
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
}



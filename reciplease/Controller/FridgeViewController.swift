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

    
    static let notification = Notification.Name("ingredientsHasBeenChanged")
    
    private let fridgeService = FridgeService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTableView.dataSource = self
        ingredientsTableView.delegate = self
        ingredientTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(onNotification(_:)), name: FridgeViewController.notification, object: nil)
    }
    
    @IBAction func didTapOnSearchForRecipesButton() {
        // To show the activity  indicator and hide the button
        toggleActivityIndicator(shown: true, activityIndicator: activityIndicator, button: searchButton)
        searchForRecipes()
    }
    
    @IBAction func didTapOnClearButton(_ sender: Any) {
        fridgeService.ingredients.removeAll()
    }
    
    @IBAction func didTapOnAddIngredientButton() {
        guard let ingredient = ingredientTextField.text else { return }
        guard ingredient.trimmingCharacters(in: .whitespaces) != "" else { return }
        
        fridgeService.ingredients.append(ingredient)
    }
    
    @objc func onNotification(_ notification: Notification) {
        ingredientsTableView.reloadData()
    }
    
    func searchForRecipes() {
        let recipeNetworkManager = RecipeNetworkManager()
        
        recipeNetworkManager.fetchRecipesFrom(fridgeService.ingredients, completion: { [weak self] (result) in
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
        return fridgeService.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell") else { return UITableViewCell() }
        cell.textLabel?.text = fridgeService.ingredients[indexPath.row]
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



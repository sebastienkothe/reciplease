//
//  RecipesViewController.swift
//  reciplease
//
//  Created by Mosma on 05/03/2021.
//

import UIKit
import Kingfisher

class RecipesViewController: BaseViewController {
    @IBOutlet private weak var recipesTableView: UITableView!
    
    var recipes: [Recipe] = []
    var coreDataManager: CoreDataManager?
    var shouldPresentFavorites = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataFunction()
        let nibName = UINib(nibName: .recipesTableViewCell, bundle: nil)
        recipesTableView.register(nibName, forCellReuseIdentifier: .recipesCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupRecipes()
        recipesTableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if
            let destinationViewController = segue.destination as? RecipeDetailsViewController,
            let recipe = sender as? Recipe
        {
            destinationViewController.recipe = recipe
        }
    }
    
    private func setupRecipes() {
        if shouldPresentFavorites {
            guard let coreDataManager = coreDataManager else { return }
            recipes = coreDataManager.recipeEntities.map { Recipe(recipeEntity: $0) }
        }
    }
    
    private func coreDataFunction() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coreDataStack = appDelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }
    
    
}

extension RecipesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        performSegue(withIdentifier: "goToRecipeDetails", sender: recipe)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipesCell") as? RecipesTableViewCell else {
            return UITableViewCell()
        }

        let recipe = recipes[indexPath.row]
        cell.configure(recipe: recipe)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

extension RecipesViewController: UITableViewDelegate { }


//
//  RecipesViewController.swift
//  reciplease
//
//  Created by Mosma on 05/03/2021.
//

import UIKit
import Kingfisher

class RecipesViewController: BaseViewController {
    @IBOutlet weak var recipesTableView: UITableView!
    
    var recipes: [Recipe] = []
    var recipeEntity: RecipeEntity?
    var coreDataManager: CoreDataManager?
    private var isFavoriteNavigation: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataFunction()
        let nibName = UINib(nibName: .recipesTableViewCell, bundle: nil)
        recipesTableView.register(nibName, forCellReuseIdentifier: .recipesCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let controllersInStack = navigationController?.viewControllers else { return }
        isFavoriteNavigation = controllersInStack.count == 1 ? true : false
    }
    
    private func coreDataFunction() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coreDataStack = appDelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }
}

extension RecipesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFavoriteNavigation {
            guard let numberOfRecipes = coreDataManager?.recipes.count else { return 0 }
            return numberOfRecipes
        } else {
            return recipes.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isFavoriteNavigation {
            let recipe = recipes[indexPath.row]
            performSegue(withIdentifier: "goToRecipeDetails", sender: recipe)
        } else {
            let recipe = coreDataManager?.recipes[indexPath.row]
            performSegue(withIdentifier: "goToRecipeDetails", sender: recipe)}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipesCell") as? RecipesTableViewCell else { return UITableViewCell() }
        if isFavoriteNavigation {
            guard let recipe = coreDataManager?.recipes[indexPath.row] else { return UITableViewCell() }
            cell.configureFavoriteRecipe(recipe: recipe)
            return cell
        } else {
            let recipe = recipes[indexPath.row]
            cell.configure(recipe: recipe)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

extension RecipesViewController: UITableViewDelegate {}

extension RecipesViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        let destinationViewController = segue.destination as? RecipeDetailsViewController
        if
            let recipe = sender as? Recipe, !isFavoriteNavigation
        {
            destinationViewController?.recipe = recipe
        } else {
            let recipe = sender as? RecipeEntity
            destinationViewController?.recipeEntity = recipe
            
        }
    }
}

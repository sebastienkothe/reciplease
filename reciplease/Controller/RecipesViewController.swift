//
//  RecipesViewController.swift
//  reciplease
//
//  Created by Mosma on 05/03/2021.
//

import UIKit
import Kingfisher


//class RecipeDataContainer {
//    init(recipe: Recipe, imageData: Data?) {
//        self.recipe = recipe
//        self.imageData = imageData
//    }
//
//    let recipe: Recipe
//    var imageData: Data?
//}

class RecipesViewController: BaseViewController {
    @IBOutlet weak var recipesTableView: UITableView!
    
    var recipes: [Recipe] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: .recipesTableViewCell, bundle: nil)
        recipesTableView.register(nibName, forCellReuseIdentifier: .recipesCell)
    }
    
    func fetchImage(url: String , completed: @escaping (UIImage) -> ()) {
        let imageURL = URL(string: url)
        var image: UIImage?
        if let url = imageURL {
            let imageData = try? Data(contentsOf: url)
            DispatchQueue.global(qos: .userInitiated).async {
                
                DispatchQueue.main.async {
                    if imageData != nil {
                        image = UIImage(data: imageData!)
                        completed(image!)
                        
                    }
                    else {
                        completed(UIImage(named: "cancel-red")!)
                    }
                    
                }
            }
        }
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipesCell") as? RecipesTableViewCell else { return UITableViewCell() }
        
        let recipe = recipes[indexPath.row]
        cell.configure(recipe: recipe)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}

extension RecipesViewController: UITableViewDelegate {}

extension RecipesViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if
            let destinationViewController = segue.destination as? RecipeDetailsViewController,
            let recipe = sender as? Recipe
        {
            destinationViewController.recipe = recipe
        }
    }
}

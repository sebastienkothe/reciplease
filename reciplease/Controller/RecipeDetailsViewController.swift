//
//  RecipeDetailsViewController.swift
//  reciplease
//
//  Created by Mosma on 05/03/2021.
//

import UIKit
import Kingfisher

class RecipeDetailsViewController: BaseViewController {
    @IBOutlet private weak var detailsRecipeTableView: UITableView!
    @IBOutlet private weak var recipeImageView: UIImageView!
    
    var recipe: Recipe?
    
    
    
    
    var currentIndexRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsRecipeTableView.dataSource = self
        detailsRecipeTableView.delegate = self
        
        setupRecipeImage()
    }
    
    private func setupRecipeImage() {
        guard let imageUrl = recipe?.image else { return }
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.kf.setImage(with: URL(string: imageUrl))
    }
}

extension RecipeDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailsRecipeCell") else { return UITableViewCell() }
        cell.textLabel?.text = "x"
        return cell
    }
    
}

extension RecipeDetailsViewController: UITableViewDelegate {}

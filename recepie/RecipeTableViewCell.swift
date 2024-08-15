//
//  RecipeTableViewCell.swift
//  recepie
//
//  Created by Student15 on 12/08/2024.
//

import UIKit


class RecipeTableViewCell: UITableViewCell {
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!

    func configure(with recipe: Recipe) {
           recipeTitleLabel.text = recipe.title
           
           if let imageUrl = recipe.imageUrl, let url = URL(string: imageUrl) {
               recipeImageView.load(url: url, placeholder: UIImage(systemName: "photo"))
           } else {
               recipeImageView.image = UIImage(systemName: "photo")
           }
       }
       
}

extension UIImageView {
    func load(url: URL, placeholder: UIImage? = nil) {
           // Set placeholder if provided
           if let placeholder = placeholder {
               self.image = placeholder
           }

           let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
               if let error = error {
                   print("Error loading image: \(error)")
                   return
               }

               guard let data = data, let image = UIImage(data: data) else {
                   print("Failed to load image from data")
                   return
               }

               DispatchQueue.main.async {
                   self?.image = image
               }
           }
           task.resume()
       }
}

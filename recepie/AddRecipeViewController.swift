//
//  AddRecipeViewController.swift
//  recepie
//
//  Created by Student15 on 13/08/2024.
//
import UIKit
import FirebaseFirestore
import FirebaseAuth
class AddRecipeViewController: UIViewController{
    
    @IBOutlet weak var RecipeName: UITextField!
    @IBOutlet weak var ImageURL: UITextField!
    

    @IBOutlet weak var Servings: UITextField!
    
    @IBOutlet weak var Minutes: UITextField!
    

    @IBOutlet weak var ingredientsTextView: UITextView!
    
   
    
    private let recipeManager = RecipeManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextViewPlaceholder()
    }
    
    private func setupTextViewPlaceholder() {
        ingredientsTextView.delegate = self
        ingredientsTextView.text = "Enter ingredients, each on a new line"
        ingredientsTextView.textColor = UIColor.lightGray
    }

    @IBAction func addButtonTapped(_ sender: UIButton) {
        guard let name = RecipeName.text, !name.isEmpty,
              let imageUrl = ImageURL.text, !imageUrl.isEmpty,
              let servingsText = Servings.text, let servings = Int(servingsText),
              let cookTimeText = Minutes.text, let cookTime = Int(cookTimeText),
              let ingredientsText = ingredientsTextView.text, !ingredientsText.isEmpty,
              let userId = Auth.auth().currentUser?.uid else {
            showAlert(message: "Please fill in all fields.")
            return
            
        }
        
        let ingredientsArray = ingredientsText
            .components(separatedBy: "\n")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
        
        let newRecipe = Recipe(
            userId: userId,
            title: name,
            ingredients: ingredientsArray,
            instructions: "", // Assuming instructions are not entered here
            imageUrl: imageUrl,
            cookTime: cookTime,
            servings: servings
        )
        
        recipeManager.saveRecipe(newRecipe) { [weak self] error in
            if let error = error {
                self?.showAlert(message: "Failed to save recipe: \(error.localizedDescription)")
            } else {
                self?.showAlert(message: "Recipe added successfully!")
                self?.clearFields()
            }
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func clearFields() {
        RecipeName.text = ""
        ImageURL.text = ""
        Servings.text = ""
        Minutes.text = ""
        ingredientsTextView.text = "Enter ingredients, each on a new line"
        ingredientsTextView.textColor = UIColor.lightGray
    }
}

// MARK: - UITextViewDelegate
extension AddRecipeViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter ingredients, each on a new line"
            textView.textColor = UIColor.lightGray
        }
    }
}


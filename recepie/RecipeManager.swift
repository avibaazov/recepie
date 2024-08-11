//
//  RecipeManager.swift
//  recepie
//
//  Created by Student15 on 11/08/2024.
//
import FirebaseFirestore
import FirebaseFirestoreSwift

class RecipeManager {
    private let db = Firestore.firestore()

    // Save a recipe to Firestore
    func saveRecipe(_ recipe: Recipe, completion: @escaping (Error?) -> Void) {
        do {
            _ = try db.collection("recipes").addDocument(from: recipe, completion: { error in
                completion(error)
            })
        } catch let error {
            completion(error)
        }
    }

    // Load recipes from Firestore
    func loadRecipes(completion: @escaping ([Recipe]?, Error?) -> Void) {
        db.collection("recipes").getDocuments { snapshot, error in
            if let error = error {
                completion(nil, error)
            } else {
                let recipes = snapshot?.documents.compactMap { document -> Recipe? in
                    try? document.data(as: Recipe.self)
                }
                completion(recipes, nil)
            }
        }
    }
}


//
//  Recipe.swift
//  recepie
//
//  Created by Student15 on 11/08/2024.
//

import Foundation

struct Recipe: Identifiable, Codable {
    var id: String? = UUID().uuidString  // Optional id initialized as a String UUID
    var title: String
    var ingredients: [String]
    var instructions: String
    var imageUrl: String?
    var cookTime: Int
    var servings: Int

    init(id: String? = UUID().uuidString, title: String, ingredients: [String], instructions: String, imageUrl: String? = nil, cookTime: Int, servings: Int) {
        self.id = id
        self.title = title
        self.ingredients = ingredients
        self.instructions = instructions
        self.imageUrl = imageUrl
        self.cookTime = cookTime
        self.servings = servings
    }
}

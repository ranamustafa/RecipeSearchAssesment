//
//  SearchRecipeModel.swift
//  SoftExpertAssement
//
//  Created by Mac on 30/06/2021.
//

import Foundation

// MARK: - SearchRecipeModel
struct SearchRecipeModel: Codable {
    let from, to, count: Int?
    let links: SearchRecipeModelLinks?
    let hits: [Hit]?
    
    enum CodingKeys: String, CodingKey {
        case from, to, count
        case links = "_links"
        case hits
    }
}
// MARK: - Hit
struct Hit: Codable {
    let recipe: Recipe?
    let links: HitLinks?
    
    enum CodingKeys: String, CodingKey {
        case recipe
        case links = "_links"
    }
}
// MARK: - HitLinks
struct HitLinks: Codable {
    let linksSelf: Next?
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}
// MARK: - Next
struct Next: Codable {
    let href: String?
    let title: String?
}
// MARK: - Recipe
struct Recipe: Codable {
    let uri: String?
    let label: String?
    let image: String?
    let source: String?
    let url: String?
    let shareAs: String?
    let yield: Double?
    let dietLabels: [String]?
    let healthLabels: [String]?
    let cautions: [String]?
    let ingredientLines: [String]?
    let ingredients: [Ingredient]?
    let calories, totalWeight: Double?
    let totalTime: Double?
    let cuisineType: [String]?
    let mealType: [String]?
    let dishType: [String]?
    let totalNutrients, totalDaily: [String: Total]?
    let digest: [Digest]?
}
// MARK: - Digest
struct Digest: Codable {
    let label: String?
    let tag: String?
    let schemaOrgTag: String?
    let total: Double?
    let hasRDI: Bool?
    let daily: Double?
    let unit: String?
    let sub: [Digest]?
}
// MARK: - Ingredient
struct Ingredient: Codable {
    let text: String?
    let weight: Double?
    let foodCategory: String?
    let foodID: String?
    let image: String?
}
// MARK: - Total
struct Total: Codable {
    let label: String?
    let quantity: Double?
    let unit: String?
}
// MARK: - SearchRecipeModelLinks
struct SearchRecipeModelLinks: Codable {
    let next: Next?
}

//
//  RecipeDetailsModel.swift
//  SoftExpertAssement
//
//  Created by Mac on 30/06/2021.
//

import Foundation


// MARK: - RecipeDetailsModel
struct RecipeDetailsModel: Codable {
    let recipe: Recipe?
    let links: Links?

    enum CodingKeys: String, CodingKey {
        case recipe
        case links = "_links"
    }
}

// MARK: - Links
struct Links: Codable {
    let linksSelf: SelfClass?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

// MARK: - SelfClass
struct SelfClass: Codable {
    let href: String?
    let title: String?
}

//// MARK: - Recipe
//struct Recipe: Codable {
//    let uri: String?
//    let label: String?
//    let image: String?
//    let source: String?
//    let url, shareAs: String?
//    let yield: Int?
//    let dietLabels, healthLabels, cautions, ingredientLines: [String]?
//    let ingredients: [Ingredient]?
//    let calories, totalWeight: Double?
//    let totalTime: Int?
//    let cuisineType, mealType, dishType: [String]?
//    let totalNutrients, totalDaily: [String: Total]?
//    let digest: [Digest]?
//}
//
//// MARK: - Digest
//struct Digest: Codable {
//    let label, tag: String?
//    let schemaOrgTag: String?
//    let total: Double?
//    let hasRDI: Bool?
//    let daily: Double?
//    let unit: Unit?
//    let sub: [Digest]?
//}
//
//enum Unit: String, Codable {
//    case empty = "%"
//    case g = "g"
//    case kcal = "kcal"
//    case mg = "mg"
//    case µg = "µg"
//}
//
//// MARK: - Ingredient
//struct Ingredient: Codable {
//    let text: String?
//    let weight: Double?
//    let foodCategory, foodID: String?
//    let image: String?
//
//    enum CodingKeys: String, CodingKey {
//        case text, weight, foodCategory
//        case foodID = "foodId"
//        case image
//    }
//}
//
//// MARK: - Total
//struct Total: Codable {
//    let label: String?
//    let quantity: Double?
//    let unit: Unit?
//}
//// MARK: - RecipeDetailsModel
//struct RecipeDetailsModel: Codable {
//    let recipe: Recipe?
//    let links: Links?
//
//    enum CodingKeys: String, CodingKey {
//        case recipe
//        case links = "_links"
//    }
//}


//
//  SearchRecipeModel.swift
//  SoftExpertAssement
//
//  Created by Mac on 30/06/2021.
//

import Foundation

//
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









//// MARK: - SearchRecipeModel
//struct SearchRecipeModel: Codable {
//    let from, to, count: Int?
//    let links: SearchRecipeModelLinks?
//    let hits: [Hit]?
//
//    enum CodingKeys: String, CodingKey {
//        case from, to, count
//        case links = "_links"
//        case hits
//    }
//}
//
//// MARK: - Hit
//struct Hit: Codable {
//    let recipe: Recipe?
//    let links: HitLinks?
//
//    enum CodingKeys: String, CodingKey {
//        case recipe
//        case links = "_links"
//    }
//}
//
//// MARK: - HitLinks
//struct HitLinks: Codable {
//    let linksSelf: Next?
//
//    enum CodingKeys: String, CodingKey {
//        case linksSelf = "self"
//    }
//}
//
//// MARK: - Next
//struct Next: Codable {
//    let href: String?
//    let title: Title?
//}
//
//enum Title: String, Codable {
//    case nextPage = "Next page"
//    case titleSelf = "Self"
//}
//
//// MARK: - Recipe
//struct Recipe: Codable {
//    let uri: String?
//    let label: String?
//    let image: String?
//    let images: Images?
//    let source: String?
//    let url: String?
//    let shareAs: String?
//    let yield: Int?
//    let dietLabels: [DietLabel]?
//    let healthLabels: [String]?
//    let cautions: [Caution]?
//    let ingredientLines: [String]?
//    let ingredients: [Ingredient]?
//    let calories, totalWeight: Double?
//    let totalTime: Int?
//    let cuisineType: [String]?
//    let mealType: [MealType]?
//    let dishType: [String]?
//    let totalNutrients, totalDaily: [String: Total]?
//    let digest: [Digest]?
//}
//
//enum Caution: String, Codable {
//    case fodmap = "FODMAP"
//    case soy = "Soy"
//    case sulfites = "Sulfites"
//}
//
//enum DietLabel: String, Codable {
//    case balanced = "Balanced"
//    case highFiber = "High-Fiber"
//    case lowCarb = "Low-Carb"
//}
//
//// MARK: - Digest
//struct Digest: Codable {
//    let label, tag: String?
//    let schemaOrgTag: SchemaOrgTag?
//    let total: Double?
//    let hasRDI: Bool?
//    let daily: Double?
//    let unit: Unit?
//    let sub: [Digest]?
//}
//
//enum SchemaOrgTag: String, Codable {
//    case carbohydrateContent = "carbohydrateContent"
//    case cholesterolContent = "cholesterolContent"
//    case fatContent = "fatContent"
//    case fiberContent = "fiberContent"
//    case proteinContent = "proteinContent"
//    case saturatedFatContent = "saturatedFatContent"
//    case sodiumContent = "sodiumContent"
//    case sugarContent = "sugarContent"
//    case transFatContent = "transFatContent"
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
//// MARK: - Images
//struct Images: Codable {
//    let thumbnail, small, regular, large: Large?
//
//    enum CodingKeys: String, CodingKey {
//        case thumbnail = "THUMBNAIL"
//        case small = "SMALL"
//        case regular = "REGULAR"
//        case large = "LARGE"
//    }
//}
//
//// MARK: - Large
//struct Large: Codable {
//    let url: String?
//    let width, height: Int?
//}
//
//// MARK: - Ingredient
//struct Ingredient: Codable {
//    let text: String?
//    let quantity: Double?
//    let measure: String?
//    let food: String?
//    let weight: Double?
//    let foodCategory: String?
//    let foodID: String?
//    let image: String?
//
//    enum CodingKeys: String, CodingKey {
//        case text, quantity, measure, food, weight, foodCategory
//        case foodID = "foodId"
//        case image
//    }
//}
//
//enum MealType: String, Codable {
//    case brunch = "brunch"
//    case lunchDinner = "lunch/dinner"
//}
//
//// MARK: - Total
//struct Total: Codable {
//    let label: String?
//    let quantity: Double?
//    let unit: Unit?
//}
//
//// MARK: - SearchRecipeModelLinks
//struct SearchRecipeModelLinks: Codable {
//    let next: Next?
//}

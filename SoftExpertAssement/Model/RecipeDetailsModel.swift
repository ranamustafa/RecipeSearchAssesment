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

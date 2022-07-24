//
//  Constants.swift
//  Money
//
//  Created by Mac on 1/20/21.
//

import Foundation
import UIKit

struct Constants {
    static var colors = Colors()
    static var nips = Nips()
    static var ids = IDs()
}

struct Colors {
    var selectedColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    var unSelectedColor = #colorLiteral(red: 0.7764705882, green: 0.8352941176, blue: 0.9176470588, alpha: 1)
}

struct Nips {
    var RecipesResultsNip = UINib(nibName: "RecipesResultsTableViewCell", bundle: nil)
    var FilterNip = UINib(nibName: "FilterCollectionViewCell", bundle: nil)
    var CartItemsNip = UINib(nibName: "CartTableViewCell", bundle: nil)
    var ChooseTableNip = UINib(nibName: "ChooseTableViewCell", bundle: nil)
}
struct IDs {
    var RecipesResultsTableViewCell = "RecipesResultsTableViewCell"
    var FilterCollectionViewCell = "FilterCollectionViewCell"
    var CartTableViewCell = "CartTableViewCell"
    var ChooseTableViewCell = "ChooseTableViewCell"
}
enum HelthLablesTypes: String {
    case All
    case Low_Sugar = "Low Sugar"
    case Keto
    case Vegan
}

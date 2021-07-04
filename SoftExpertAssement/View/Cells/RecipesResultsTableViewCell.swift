//
//  RecipesResultsTableViewCell.swift
//  SoftExpertAssement
//
//  Created by Mac on 01/07/2021.
//

import UIKit
import Kingfisher

class RecipesResultsTableViewCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var dishImage: UIImageView!
    @IBOutlet weak var recipeTitleLBL: UILabel!
    @IBOutlet weak var sourceLBL: UILabel!
    @IBOutlet weak var recipeHelthLBL: UILabel!
    //MARK:- Properties
    var helthlables: [String]?
    
    //MARK:- LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    //MARK:- Helper Methods
    func configCell(recips: Hit?){
        recipeTitleLBL.text = recips?.recipe?.label
        sourceLBL.text = recips?.recipe?.source
        helthlables = recips?.recipe?.healthLabels
        let joined = helthlables?.joined(separator: " , ")
        recipeHelthLBL.text = joined
        let imageUrl = URL(string: recips?.recipe?.image ?? "")
        dishImage.clipsToBounds = true
        dishImage.kf.indicatorType = .activity
        dishImage.kf.setImage(with: imageUrl, placeholder: UIImage(named: "dish") )
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        }
    
}

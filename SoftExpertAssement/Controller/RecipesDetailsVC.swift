//
//  RecipesDetailsVC.swift
//  SoftExpertAssement
//
//  Created by Mac on 01/07/2021.
//


/*
 This Class is considered to display the choosen Recipe details (
 ● Recipe’s image
 ● Recipe title
 ● Recipe ingredients each on a separate line. “ingredientLines”
 ● Button with the link to the recipe from the publisher’s website “url” ),  and allowd the user to share it and  allow to the web page  open in a ‘SFSafariViewController’
 */

import UIKit
import SafariServices
import Kingfisher

class RecipesDetailsVC: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var dishImage: UIImageView!
    @IBOutlet weak var recipeTitleLBL: UILabel!
    @IBOutlet weak var recipeIngrediantsLBL: UILabel!
    
    //MARK: - Properties
    var item : Recipe?
    var urlToShare: String?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavigationBar()
        populateData()
    }
    
    //MARK: - IBAction
    @IBAction func goToRecipeWebSiteBtnPressed(_ sender: UIButton) {
        showRecipeOnWebsite(self.urlToShare ?? "")
    }
    
    //MARK: - Helper Methods
    private func populateData(){
        let imageUrl = URL(string: item?.image ?? "")
        dishImage.clipsToBounds = true
        dishImage.kf.indicatorType = .activity
        dishImage.kf.setImage(with: imageUrl, placeholder: UIImage(named: "dish") )
        recipeTitleLBL.text = item?.label
        let ingrediants = item?.ingredientLines
        let joined = ingrediants?.joined(separator: " \n - ")
        recipeIngrediantsLBL.text = joined
        urlToShare = item?.shareAs
    }
    private func customizeNavigationBar(){
        self.title = "Recipe Details"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareBarButtonItemClicked(_:)))
    }
    
    @objc func shareBarButtonItemClicked(_ sender: UIBarButtonItem) {
        let textToShare = String(describing: "Share the recipe")
        let urlToShare =  self.urlToShare ?? ""
        let items = [textToShare, urlToShare] as [Any]
        let avc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        avc.excludedActivityTypes = [
            UIActivity.ActivityType.airDrop,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList
        ]
        if UIDevice.current.userInterfaceIdiom == .pad {
            if avc.responds(to: #selector(getter: UIViewController.popoverPresentationController)) {
                avc.popoverPresentationController?.barButtonItem = sender
            }
        }
        self.present(avc, animated: true, completion: nil)
    }
    
    private func showRecipeOnWebsite(_ recipeURL: String) {
        if let url = URL(string: recipeURL) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
}

//
//  RecipesSearchVC.swift
//  SoftExpertAssement
//
//  Created by Mac on 01/07/2021.
//



/*
 This Class is considered to display the a search bar to allow th user to enter his required recipe name or food ingredient then appear the result in table view list appearing some information like (
 ● Recipe’s image
 ● Recipe’s title
 ● Source
 ● Recipe’s health labels) after API calling , it also has filter option which allow th user to filter the results appear depending on a health filter from the available filters (Low Sugar, Keto & Vegan) and when no filter appy all the results will appear normmaly
 */

import UIKit
import PKHUD

class RecipesSearchVC: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet weak var noResultPlaceHolderImage: UIImageView!
    @IBOutlet weak var searchForFoodLInitBL: UILabel!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewContainetTopConstrain: NSLayoutConstraint!
    
    //MARK: - Properties
    var query : String?
    var recipesResults : [Hit] = []{
        didSet{
            resultsTableView.reloadData()
        }
    }
    let healthFilterTitles: [HelthLablesTypes : String] = [.All : "All",.Low_Sugar: "Low Sugar", .Keto: "Keto", .Vegan: "Vegan"]
    let healthFilterTypes: [HelthLablesTypes] = [.All, .Low_Sugar, .Keto, .Vegan]
    var selectedCatIndexPath: IndexPath = [0,0]
    var selectedCat: HelthLablesTypes = .All
    
    //MARK: - pagination handling
    var nextPageUrl:String!
    var pageNumber : Int?
    var previusPageNumber : Int?
    var remaining: Int?
    
    //MARK: -handle search
    var isSearching:Bool = false
    var searchHistory: [String] = []
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        screenInitDesign()
        searchBarSetup()
        tableViewSetup()
        registerTableViewCell()
        collectionViewSetup()
        registerCollectionViewCell()
    }
    
    //MARK: - Helper Methods
    private func screenInitDesign(){
        self.resultsTableView.isHidden = true
        self.noResultPlaceHolderImage.isHidden = false
        self.noResultPlaceHolderImage.image = #imageLiteral(resourceName: "what")
        self.searchForFoodLInitBL.isHidden = false
    }
    private func searchBarSetup(){
        searchBar.delegate = self
        searchBar.placeholder = "search for recipe"
    }
    private func collectionViewSetup(){
        filterCollectionView.dataSource = self
        filterCollectionView.delegate = self
    }
    private func registerCollectionViewCell(){
        filterCollectionView.register(Constants.nips.FilterNip, forCellWithReuseIdentifier: Constants.ids.FilterCollectionViewCell)
    }
    private func tableViewSetup(){
        resultsTableView.dataSource = self
        resultsTableView.delegate = self
    }
    private func registerTableViewCell(){
        resultsTableView.register(Constants.nips.RecipesResultsNip, forCellReuseIdentifier: Constants.ids.RecipesResultsTableViewCell)
        resultsTableView.register(Constants.nips.SearchHistoryTableViewCell, forCellReuseIdentifier: Constants.ids.SearchHistoryTableViewCell)
    }
    private func checkIfNoResults(_ array: [Hit]){
        if array.isEmpty{
            self.resultsTableView.isHidden = true
            self.searchForFoodLInitBL.isHidden = false
            self.searchForFoodLInitBL.text = "No results for this option"
            self.noResultPlaceHolderImage.isHidden = false
            self.noResultPlaceHolderImage.image = #imageLiteral(resourceName: "sad")
        }else{
            self.resultsTableView.isHidden = false
            self.searchForFoodLInitBL.isHidden = true
            self.noResultPlaceHolderImage.isHidden = true
            self.resultsTableView.reloadData()
        }
    }
    private func checkIfSearchBarEditing(isSearch: Bool){
        if isSearch{
            //true : in searcBar
            DispatchQueue.main.async {
                self.collectionViewHeight.constant = 0
                self.tableViewContainetTopConstrain.constant = 0
                self.resultsTableView.reloadData()
            }
        }else{
            DispatchQueue.main.async {
                self.collectionViewHeight.constant = 70
                self.tableViewContainetTopConstrain.constant = 90
                self.resultsTableView.reloadData()
            }
        }
    }
    private func getSeachHistory(){
        let history = SearchSavedData.shared.fetchSearchTextArray()
        self.searchHistory = history
        self.resultsTableView.reloadData()
    }

}
//MARK: - UITableViewDelegate, UITableViewDataSource

extension RecipesSearchVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            return searchHistory.count
        }else{
            
            return recipesResults.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipeCell = resultsTableView.dequeueReusableCell(withIdentifier: Constants.ids.RecipesResultsTableViewCell) as! RecipesResultsTableViewCell
        let searchCell = resultsTableView.dequeueReusableCell(withIdentifier: Constants.ids.SearchHistoryTableViewCell) as! SearchHistoryTableViewCell
        
        if isSearching{
            searchCell.selectionStyle = .none
            searchCell.searchHistoryTxtLBL.text = self.searchHistory[indexPath.row]
            return searchCell
        }else{
            recipeCell.selectionStyle = .none
            recipeCell.configCell(recips: recipesResults[indexPath.row])
            return recipeCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearching{
            isSearching = false
            searchBar.text = searchHistory[indexPath.row]
            self.query = searchHistory[indexPath.row]
            checkIfSearchBarEditing(isSearch: isSearching)
            self.recipesResults.removeAll()
            let url = APIs.shared.searchRecipesByWords(quary: self.query ?? "")
            getRecipsByQuery(for: url, showLoading: true)
        }else{
            let vc = AppStoryboard.Main.viewController(viewControllerClass: RecipesDetailsVC.self)
            vc.item = self.recipesResults[indexPath.row].recipe
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Aimation handling
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animate(withDuration: 0.3, animations: {
            cell.layer.transform = CATransform3DMakeScale(1.05,1,1)
        },completion: { finished in
            UIView.animate(withDuration: 0.1, animations: {
                cell.layer.transform = CATransform3DMakeScale(1.05,1,1)
            })
        })
        // pagination handling
        if indexPath.section == 0{
            if(indexPath.row == (self.recipesResults.count)-1){
                if(self.pageNumber ?? 0 <= self.previusPageNumber ?? 0){
                    if(nextPageUrl != nil){
                        let spinner = UIActivityIndicatorView()
                        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
                        spinner.startAnimating()
                        tableView.tableFooterView = spinner
                        tableView.tableFooterView?.isHidden = false
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            guard let nextURL = self.nextPageUrl  else {return}
                            self.getRecipsByQuery(for: nextURL, showLoading: false)
                        }
                    }
                    else{
                        tableView.tableFooterView?.removeFromSuperview()
                        let view = UIView()
                        view.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(5))
                        tableView.tableFooterView = view
                        tableView.tableFooterView?.isHidden = true
                    }
                }
                else{
                    tableView.tableFooterView?.removeFromSuperview()
                    let view = UIView()
                    view.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(5))
                    tableView.tableFooterView = view
                    tableView.tableFooterView?.isHidden = true
                }
            }
            else{
                tableView.tableFooterView?.removeFromSuperview()
                let view = UIView()
                view.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(5))
                tableView.tableFooterView = view
                tableView.tableFooterView?.isHidden = true
            }
        }

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isSearching{
            return 30
        }else{
            return UITableView.automaticDimension
        }
    }
}

//MARK: - UICollectionViewelegate, UICollectionViewDataSource

extension RecipesSearchVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return healthFilterTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = filterCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.ids.FilterCollectionViewCell, for: indexPath) as? FilterCollectionViewCell
        cell?.backgroundColor = (selectedCatIndexPath == indexPath) ? Constants.colors.selectedColor : Constants.colors.unSelectedColor
        cell?.filterTitleLBL.text = healthFilterTitles[healthFilterTypes[indexPath.row]]
            return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.resultsTableView.numberOfRows(inSection: 0) > 0 {
            self.resultsTableView.scrollToRow(at: [0,0], at: .top, animated: true)
        }
        let previouslySelectedCell = collectionView.cellForItem(at: selectedCatIndexPath) as! FilterCollectionViewCell
        previouslySelectedCell.backgroundColor = Constants.colors.unSelectedColor
        let newSelectedCell = collectionView.cellForItem(at: indexPath) as! FilterCollectionViewCell
        newSelectedCell.backgroundColor = Constants.colors.selectedColor
        selectedCatIndexPath = indexPath
        selectedCat = healthFilterTypes[indexPath.row]
        switch selectedCat{
        case .All:
            self.recipesResults.removeAll()
            let url = APIs.shared.searchRecipesByWords(quary: self.query ?? "")
            HUD.show(.progress, onView: self.view)
            getRecipsByQuery(for: url, showLoading: true)
            self.checkIfNoResults(recipesResults)
        case .Low_Sugar:
            self.recipesResults.removeAll()
            let url = APIs.shared.searchRecipesByHealth(quary: self.query ?? "", health: "low-sugar")
            HUD.show(.progress, onView: self.view)
            getRecipsByQuery(for: url, showLoading: true)
            self.checkIfNoResults(recipesResults)
        case .Keto:
            self.recipesResults.removeAll()
            let url = APIs.shared.searchRecipesByHealth(quary: self.query ?? "", health: "keto-friendly")
            HUD.show(.progress, onView: self.view)
            getRecipsByQuery(for: url, showLoading: true)
            self.checkIfNoResults(recipesResults)
        case .Vegan:
            self.recipesResults.removeAll()
            let url = APIs.shared.searchRecipesByHealth(quary: self.query ?? "", health: "vegan")
            HUD.show(.progress, onView: self.view)
            getRecipsByQuery(for: url, showLoading: true)
            self.checkIfNoResults(recipesResults)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 40) / 4
        return CGSize(width: width, height: 40)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
//MARK: - SearchBar Delegates
extension RecipesSearchVC: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let searchText = searchBar.text{
            guard searchText.isEnglishLetters(searchText) else {
                self.popAlert(title: "Invalid", message: "Kindly check your search item in english letters only. ")
                return
            }
            guard searchText.isWhiteSpace(searchText) else {
                self.popAlert(title: "", message: "Empty spaces are not allowed")
                return
            }
            recipesResults = []
            let q = searchText
            self.query = q
            let url = APIs.shared.searchRecipesByWords(quary: q)
            HUD.show(.progress, onView: self.view)
            getRecipsByQuery(for: url, showLoading: true)
            SearchSavedData.shared.addTextToSearchArrayHistory(textToAdd: self.query ?? "")
            isSearching = false
            checkIfSearchBarEditing(isSearch: isSearching)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("start edite in search bar ")
        self.getSeachHistory()
        isSearching = true
        checkIfSearchBarEditing(isSearch: isSearching)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = true
        checkIfSearchBarEditing(isSearch: isSearching)
        self.getSeachHistory()
    }
}

//MARK: - Networking
extension RecipesSearchVC{
    func getRecipsByQuery(for url: String, showLoading: Bool){
        NetworkManager.shared.fetchAllProducts(url: url) { [weak self] products, error in
            guard let strongSelf = self else {return}
            HUD.hide()
            guard let response = products else {
                strongSelf.popAlert(title: "", message: error ?? "")
                return
            }
            guard let resultProducts = response.hits else {
                strongSelf.popAlert(title: "", message: error ?? "")
                return
            }
            strongSelf.recipesResults.append(contentsOf: resultProducts)
            strongSelf.nextPageUrl = response.links?.next?.href
            strongSelf.checkIfNoResults(strongSelf.recipesResults)
        }
    }
}

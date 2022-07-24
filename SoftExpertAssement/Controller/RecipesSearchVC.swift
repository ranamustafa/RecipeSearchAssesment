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

enum HelthLablesTypes: String {
    case All
    case Low_Sugar = "Low Sugar"
    case Keto
    case Vegan
}

class RecipesSearchVC: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet weak var noResultPlaceHolderImage: UIImageView!
    @IBOutlet weak var searchForFoodLInitBL: UILabel!
    //MARK: - Properties
    var query : String?
    var recipesResults : [Hit] = []{
        didSet{
//            filteredArray = recipesResults
            resultsTableView.reloadData()
        }
    }
    var filteredArray: [Hit] = [] {
        didSet{
            print("Filterd Array !!! \(self.filteredArray)")
            resultsTableView.reloadData()
        }
    }
    let healthFilterTitles: [HelthLablesTypes : String] = [.All : "All",.Low_Sugar: "Low Sugar", .Keto: "Keto", .Vegan: "Vegan"]
    let healthFilterTypes: [HelthLablesTypes] = [.All, .Low_Sugar, .Keto, .Vegan]
    var selectedCatIndexPath: IndexPath = [0,0]
    var selectedCat: HelthLablesTypes = .All
    var isFilterd: Bool = false
    
    //MARK: - pagination handling
    var nextPageUrl:String!{
        didSet{
            print("NEXT URL : \(String(describing: self.nextPageUrl))")
        }
    }
    var pageNumber : Int?
    var previusPageNumber : Int?
    var remaining: Int?
    
    
    //MARK:- LifeCycle
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

}
//MARK:- UITableViewDelegate, UITableViewDataSource

extension RecipesSearchVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFilterd{
            return filteredArray.count
        }else{
            
            return recipesResults.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultsTableView.dequeueReusableCell(withIdentifier: Constants.ids.RecipesResultsTableViewCell, for: indexPath) as? RecipesResultsTableViewCell
        cell?.selectionStyle = .none
        if isFilterd{
            cell?.configCell(recips: filteredArray[indexPath.row])
        }else{
            cell?.configCell(recips: recipesResults[indexPath.row])
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // initiate itemVC
        let vc = AppStoryboard.Main.viewController(viewControllerClass: RecipesDetailsVC.self)// initiate items VC
        vc.item = self.recipesResults[indexPath.row].recipe
        // push to the recipe details VC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // To handel animation of viwing the cells
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
        return UITableView.automaticDimension

    }
    
}

//MARK: - UICollectionViewelegate, UICollectionViewDataSource

extension RecipesSearchVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return healthFilterTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = filterCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.ids.FilterCollectionViewCell, for: indexPath) as? FilterCollectionViewCell
        // ternary operator to set cell background color according to selected category indexpath
        cell?.backgroundColor = (selectedCatIndexPath == indexPath) ? Constants.colors.selectedColor : Constants.colors.unSelectedColor
        
        cell?.filterTitleLBL.text = healthFilterTitles[healthFilterTypes[indexPath.row]] // set filter title for cell label
        
        
            return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.resultsTableView.numberOfRows(inSection: 0) > 0 { // checl if there is rows in tableview
            self.resultsTableView.scrollToRow(at: [0,0], at: .top, animated: true) // scroll tableview to the top
        }
        // refrence to previously selected cell
        let previouslySelectedCell = collectionView.cellForItem(at: selectedCatIndexPath) as! FilterCollectionViewCell
        // set background color of previously selected cell
        previouslySelectedCell.backgroundColor = Constants.colors.unSelectedColor
        
        // refrence to new selected cell
        let newSelectedCell = collectionView.cellForItem(at: indexPath) as! FilterCollectionViewCell
        // set background color of new selected cell
        newSelectedCell.backgroundColor = Constants.colors.selectedColor
        
        // set selectedCat variable to selected indexpath
        selectedCatIndexPath = indexPath
        selectedCat = healthFilterTypes[indexPath.row]
        print("selected category \(selectedCat.rawValue)")

        let filtered = recipesResults.filter({ ($0.recipe?.healthLabels?.contains(selectedCat.rawValue))! })
//        self.filteredArray = filtered
      
       

        switch selectedCat{
        case .All:
            let url = APIs.shared.searchRecipesByWords(quary: self.query ?? "")
//            getRecipsByQuery(for: url, showLoading: true)
            self.isFilterd = false
//            self.resultsTableView.reloadData()
            self.checkIfNoResults(recipesResults)
        case .Low_Sugar:
            self.isFilterd = true
//            let url
            
            
            
//            filteredArray.removeAll()
//            filteredArray.append(contentsOf: filtered)
//            self.checkIfNoResults(filteredArray)
        case .Keto:
            self.isFilterd = true
            filteredArray.removeAll()
            filteredArray.append(contentsOf: filtered)
            self.checkIfNoResults(filteredArray)
        case .Vegan:
            self.isFilterd = true
            filteredArray.removeAll()
            filteredArray.append(contentsOf: filtered)
            self.checkIfNoResults(filteredArray)
        }
    }
    // set size for each cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 40) / 4  // devide the collection view width to appeare only 3 celles centeralized ( -30 ) is the 5 left and 5 right edge insets and 10 minimumInteritemSpacing between cells
        return CGSize(width: width, height: 40)
    }

    // set insets between collectionview and cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5) // conserns about the spacing between the right and left edges
    }

    // set interitem spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // spacing between cells
    }

    
}
//MARK:- SearchBar Delegates
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
            getRecipsByQuery(for: url, showLoading: true)
            
            
        }
    }
}

//MARK: - Networking
extension RecipesSearchVC{
    func getRecipsByQuery(for url: String, showLoading: Bool) {
        
        WebServices.getRecipes(vc: self, showLoading: showLoading, url: url) { (data, error) in
            if error == nil && data == nil {
                print("Connection failed")
                
            } else if error != nil {
                HUD.flash(.labeledError(title: "", subtitle: error), delay: 0.5)
                
            } else {
                DispatchQueue.main.async {
                    self.recipesResults.append(contentsOf: data?.hits ?? [])
                    self.nextPageUrl = data?.links?.next?.href
                    switch self.recipesResults.count{
                    case 0 :
                        self.resultsTableView.isHidden = true
                        self.searchForFoodLInitBL.isHidden = false
                        self.noResultPlaceHolderImage.isHidden = false
                        self.noResultPlaceHolderImage.image = #imageLiteral(resourceName: "sad")
                        HUD.flash(.labeledError(title: "", subtitle: "No results for this recipe"), delay: 0.5)
                    default:
                        self.noResultPlaceHolderImage.isHidden = true
                        self.searchForFoodLInitBL.isHidden = true
                        self.resultsTableView.isHidden = false
    
                    }
                }
            }
        }
    }
}

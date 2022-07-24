//
//  SearchSavedData.swift
//  SoftExpertAssement
//
//  Created by Rana Mustafa on 24/07/2022.
//

import Foundation

struct SearchSavedData {
    
    
    static var shared = SearchSavedData()
    
    private init() {}
    
    private let Defaults = UserDefaults.standard
    
    func addTextToSearchArrayHistory(textToAdd: String){
        let addedtext = textToAdd
        if  checkIfTextInArray(text: addedtext) {
            print("item is in array ")
        }else{
            
            if fetchSearchTextArray().count < 10 {
                if let data = UserDefaults.standard.value(forKey:"SavedItem") as? Data {
                    var recivedItems = try? PropertyListDecoder().decode(Array<String>.self, from: data)
                    recivedItems?.append(addedtext)
                    UserDefaults.standard.set(try? PropertyListEncoder().encode(recivedItems), forKey:"SavedItem")
                }else{
                    UserDefaults.standard.set(try? PropertyListEncoder().encode([addedtext]), forKey:"SavedItem")
                }
                
            }else{
                if let data = UserDefaults.standard.value(forKey:"SavedItem") as? Data {
                    var recivedItems = try? PropertyListDecoder().decode(Array<String>.self, from: data)
//                    recivedItems?.append(addedtext)
                    recivedItems?[0] = addedtext
                    UserDefaults.standard.set(try? PropertyListEncoder().encode(recivedItems), forKey:"SavedItem")
                }else{
                    UserDefaults.standard.set(try? PropertyListEncoder().encode([addedtext]), forKey:"SavedItem")
                }
                
            }
        }

    }
    func fetchSearchTextArray() -> [String]{
        if let data = UserDefaults.standard.value(forKey:"SavedItem") as? Data {
            let recivedItems = try? PropertyListDecoder().decode(Array<String>.self, from: data)
            return recivedItems ?? [String]()
        }
        return [String]()
    }
    func checkIfTextInArray(text: String) -> Bool{
        if fetchSearchTextArray().contains(text){
            return true
        }else{
            return false
        }
    }
    
}

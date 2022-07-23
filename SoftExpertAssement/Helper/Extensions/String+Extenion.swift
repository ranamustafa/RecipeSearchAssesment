//
//  String+Extenion.swift
//  SoftExpertAssement
//
//  Created by Rana Mustafa on 22/07/2022.
//

import Foundation

extension String{
    func isEnglishLetters(_ string: String) -> Bool {
        return string.range(of: ".*[^A-Za-z0-9].*", options: .regularExpression) == nil
    }
    func isWhiteSpace(_ string: String) -> Bool{
        return string.trimmingCharacters(in: .whitespaces).isEmpty == false
    }
}

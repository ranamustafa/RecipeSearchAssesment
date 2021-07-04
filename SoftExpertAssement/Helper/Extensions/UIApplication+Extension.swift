//
//  UIApplication+Extension.swift
//  Money
//
//  Created by Mac on 1/20/21.
//

import Foundation
import UIKit

extension UIApplication {
    
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}

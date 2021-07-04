//
//  UITextField+Extension.swift
//  Money
//
//  Created by Mac on 1/20/21.
//

import Foundation
import UIKit

extension UITextField {

    func setUnderLine(color: CGColor, width: CGFloat) {
        let border = CALayer()
        let width = width
        border.borderColor = color
        border.frame = CGRect(x: self.bounds.height - 1, y: self.bounds.height - 1, width: self.bounds.width, height: 1.0)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    func setLeftPaddingPoints(_ amount:CGFloat){
           let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
           self.leftView = paddingView
           self.leftViewMode = .always
       }
       func setRightPaddingPoints(_ amount:CGFloat) {
           let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
           self.rightView = paddingView
           self.rightViewMode = .always
       }

}


extension UITextField{
   @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

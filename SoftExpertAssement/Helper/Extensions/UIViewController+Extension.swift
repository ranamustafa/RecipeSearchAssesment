//
//  UIViewController+Extension.swift
//  Money
//
//  Created by Mac on 1/20/21.
//

import Foundation
import  UIKit
import PKHUD


extension UIViewController{
    
    //MARK:  default pop Alert Function
    public func popAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
        //    let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okButton)
        //    alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    // inorder to check if the textField is ebty or not
    public func isTFEmbty(myTF: UITextField , message: String) -> Bool {
        if (myTF.text?.isEmpty)! {
            HUD.flash(.label(message), delay: 1.0)
            return true
        }else{
            return false
        }
    }
    /* function to customize the Statues bar */
    
    func setStatusBar(color: UIColor) {
        let tag = 12321
        if let taggedView = self.view.viewWithTag(tag){
            taggedView.removeFromSuperview()
        }
        let overView = UIView()
        overView.frame = UIApplication.shared.statusBarFrame
        overView.backgroundColor = color
        overView.tag = tag
        self.view.addSubview(overView)
    }
    /* function to show toast*/
    func showToast(message : String, seconds: Double = 2.0) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        self.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    /* function to convert string to array of string when seperated by comma (,)*/
    func strToArr(theString: String) -> [String]{
        let separators = NSCharacterSet(charactersIn: ",")
        var myString: String = theString;
        var theArr = myString.components(separatedBy: separators as CharacterSet)
        print("the string arr \(theArr)")
        return theArr
    }
}


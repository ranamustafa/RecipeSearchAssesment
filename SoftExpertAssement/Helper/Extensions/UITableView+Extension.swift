//
//  UITableView+Extension.swift
//  Money
//
//  Created by Mac on 1/20/21.
//

import Foundation
import UIKit

extension UITableView {
    
    func registerCellNib<Cell: UITableViewCell>(cellClass: Cell.Type){
        self.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellReuseIdentifier: String(describing: Cell.self))
    }


    func dequeue<Cell: UITableViewCell>() -> Cell{
        let identifier = String(describing: Cell.self)
        
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier) as? Cell else {
            fatalError("Error in cell")
        }
        
        return cell
    }
        
}

extension UITableView {
    func addSpinnerFooter() {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 200))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        spinner.color = .lightGray
        footerView.addSubview(spinner)
        spinner.startAnimating()
        self.tableFooterView = footerView
    }
}

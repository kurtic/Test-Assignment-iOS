//
//  UITableView+Utils.swift
//  CardTestApp
//
//  Created by Diachenko Ihor on 14.07.2023.
//

import UIKit

extension UITableView {
    func registerNib<T>(for cellClass: T.Type) where T: UITableViewCell {
        let identifier = String(describing: cellClass)
        register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(cellClass: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: cellClass), for: indexPath) as! T
    }
}

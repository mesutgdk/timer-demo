//
//  Extension.swift
//  task3_app
//
//  Created by Mesut Gedik on 1.09.2023.
//

import UIKit

extension UIView{
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}

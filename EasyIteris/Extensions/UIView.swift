//
//  UIView.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 24/09/19.
//

import UIKit

extension UIView {
    static func fromNib<T>(withOwner: Any? = nil, options: [UINib.OptionsKey: Any]? = nil) -> T? where T: UIView {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: "\(self)", bundle: bundle)
        return nib.instantiate(withOwner: withOwner, options: options).first as? T
    }
}

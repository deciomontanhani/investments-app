//
//  UIButton.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 23/09/19.
//

import UIKit

extension UIButton {
    func setDisableState() {
        isEnabled = false
        setBackgroundColor(UIColor.disableButtonBackground, forState: .disabled)
        setTitleColor(UIColor.appWarmGrey, for: .disabled)
    }

    func setEnableState() {
        isEnabled = true
        setTitleColor(UIColor.white, for: .normal)
        setBackgroundColor(UIColor.appGreen, forState: .normal)
        setTitleColor(UIColor.white, for: .highlighted)
        setBackgroundColor(UIColor.appGreen, forState: .highlighted)
    }

    func setBackgroundColor(_ color: UIColor, forState: UIControl.State) {
        clipsToBounds = true
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            setBackgroundImage(colorImage, for: forState)
        }
    }
}

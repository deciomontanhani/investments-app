//
//  UIFont.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 23/09/19.
//

import UIKit

extension UIFont {
    private class func appDefaultFont(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }

    static func appRegularFont(ofSize size: FontSize) -> UIFont {
        guard let font = UIFont(name: FontName.appRegular.rawValue, size: size.rawValue) else {
            return appDefaultFont(FontSize.small.rawValue)
        }
        return font
    }

    static func appBoldFont(ofSize size: FontSize) -> UIFont {
        guard let font = UIFont(name: FontName.appBold.rawValue, size: size.rawValue) else {
            return appDefaultFont(FontSize.small.rawValue)
        }
        return font
    }

    static func appLightFont(ofSize size: FontSize) -> UIFont {
        guard let font = UIFont(name: FontName.appLight.rawValue, size: size.rawValue) else {
            return appDefaultFont(FontSize.small.rawValue)
        }
        return font
    }
}

// MARK: - Enums

enum FontName: String {
    case appBold = "ItauTextApp-Bold"
    case appLight = "ItauTextApp-Light"
    case appRegular = "Helvetica-Regular"
    case appXBold = "ItauTextApp-XBold"
    case master = "itaufonts_master_24px_v1"
    case displayBold = "ItauDisplay-Bold"
    case displayRegular = "ItauDisplay-Regular"
}

enum FontSize: CGFloat {
    case xSmall = 8.0
    case tiny = 9.0
    case footnote = 11.0
    case small = 12.0
    case regular = 13.0
    case normal = 14.0
    case large = 16.0
    case xLarge = 18.0
    case exLarge = 20.0
    case xgLarge = 22.0
    case xxLarge = 24.0
    case xxxLarge = 32.0
    case superLarge = 48.0
}

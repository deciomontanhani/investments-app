//
//  Shimmer.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 24/09/19.
//

import Foundation
import UIKit

final class ShimmerConstants {
    static let kKeyPathAnimation = "locations"
    static let kAnimationShimmer = "shimmer"
    static let kIdViewShimmer = "shimmerView"
    static let kConstBaseView: Int = 999
    static let kConstPercentOfHeight: CGFloat = 0.2
    static let kCornerRadius: CGFloat = 3
    static let kAlphaColor: CGFloat = 0.5
    static let kShimmerDuration: Double = 0.9
    static let kStartPoint = CGPoint(x: 0, y: 0.5)
    static let kEndPoint = CGPoint(x: 1, y: 0.5)
}

@objc extension UIView {
    private static var _shimmerBaseColor = UIColor.lightGray.withAlphaComponent(ShimmerConstants.kAlphaColor)

    var shimmerBaseColor: UIColor {
        get {
            return UIView._shimmerBaseColor
        }
        set(newValue) {
            UIView._shimmerBaseColor = newValue
        }
    }

    private static var disabledShimmer: Bool = ProcessInfo.processInfo.arguments.contains("UITest")

    // MARK: - Shimmer

    func startShimmering() {
        if UIView.disabledShimmer {
            return
        }

        let light = UIColor.white.cgColor
        let dark = shimmerBaseColor.cgColor

        let gradient = CAGradientLayer()
        gradient.colors = [light, dark, dark, light]
        gradient.frame = CGRect(x: -bounds.width, y: 0, width: 3 * bounds.width, height: bounds.height)
        gradient.startPoint = ShimmerConstants.kStartPoint
        gradient.endPoint = ShimmerConstants.kEndPoint
        gradient.locations = [0.3, 0.4, 0.5, 0.6]
        layer.mask = gradient

        let animation = CABasicAnimation(keyPath: ShimmerConstants.kKeyPathAnimation)
        animation.fromValue = [0.0, 0.1, 0.2, 0.3]
        animation.toValue = [0.7, 0.8, 0.9, 1.0]
        animation.duration = ShimmerConstants.kShimmerDuration
        animation.repeatCount = .infinity
        gradient.add(animation, forKey: ShimmerConstants.kAnimationShimmer)
    }

    func stopShimmering() {
        layer.mask = nil
    }

    func isShimmering() -> Bool {
        var result = false
        for subView: UIView in subviews {
            if !subView.subviews.isEmpty {
                result = result || subView.isShimmering()
            } else {
                result = result || hasShimmer(in: subView)
            }
        }
        return result
    }

    // MARK: - Placeholder

    func startPlaceholdering() {
        stopPlaceholdering()
        for subView: UIView in subviews {
            if !subView.subviews.isEmpty, !(subView is UIButton) {
                subView.startPlaceholdering()
            } else {
                addLoadingEffect(to: subView)
            }
        }
    }

    func stopPlaceholdering() {
        for subView: UIView in subviews {
            if !subView.subviews.isEmpty, !(subView is UIButton) {
                subView.stopPlaceholdering()
            } else {
                removeLoadingEffect(from: subView)
            }
        }
    }

    // MARK: - Others Methods

    func addLoadingEffect(to view: UIView?) {
        let height = getLoadingHeightAndConfigureView(view)
        if height > 0 {
            guard let frameHeight = view?.frame.height,
                let minX = view?.bounds.minX,
                let width = view?.frame.width else {
                return
            }
            let center: CGFloat = (frameHeight - height) / 2
            let bounds = CGRect(x: minX, y: center, width: width, height: height)
            let baseView = UIView(frame: bounds)
            baseView.tag = ShimmerConstants.kConstBaseView
            baseView.backgroundColor = baseShimmerColor()
            if backgroundColor?.cgColor == UIColor.white.cgColor || backgroundColor == nil {
                baseView.backgroundColor = baseShimmerColor()?.withAlphaComponent(1)
            }
            baseView.layer.cornerRadius = ShimmerConstants.kCornerRadius
            baseView.layer.masksToBounds = true
            view?.addSubview(baseView)
            view?.bringSubviewToFront(baseView)
            baseView.accessibilityIdentifier = ShimmerConstants.kIdViewShimmer
            baseView.startShimmering()
        }
    }

    func removeLoadingEffect(from view: UIView?) {
        let viewBase: UIView? = view?.viewWithTag(ShimmerConstants.kConstBaseView)
        if viewBase != nil {
            viewBase?.removeFromSuperview()
        }
    }

    func hasShimmer(in view: UIView?) -> Bool {
        if view?.tag == ShimmerConstants.kConstBaseView {
            return true
        } else {
            let viewBase: UIView? = view?.viewWithTag(ShimmerConstants.kConstBaseView)
            if viewBase != nil {
                return true
            }
        }
        return false
    }

    func getLoadingHeightAndConfigureView(_ view: UIView?) -> CGFloat {
        var height: CGFloat = 0
        if view is UILabel {
            let label = view as? UILabel
            if let labelFontPointSize = label?.font.pointSize {
                height = labelFontPointSize + (labelFontPointSize * ShimmerConstants.kConstPercentOfHeight)
            }
            if let labelFrameHeight = label?.frame.height, height > labelFrameHeight {
                height = labelFrameHeight
            }

            label?.textColor = UIColor.clear
        } else if view is UIImageView {
            let imageView = view as? UIImageView
            if let frameHeight = imageView?.frame.height {
                height = frameHeight
            }
            imageView?.image = nil
        } else if view is UIButton {
            let button = view as? UIButton
            if let buttonPointSize = button?.titleLabel?.font.pointSize {
                height = buttonPointSize
            }
            button?.setTitleColor(UIColor.clear, for: .normal)
        }
        return height
    }

    func baseShimmerColor() -> UIColor? {
        return shimmerBaseColor
    }
}

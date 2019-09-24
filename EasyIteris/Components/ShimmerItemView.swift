//
//  ShimmerItemView.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 24/09/19.
//

import UIKit

@IBDesignable
class ShimmerItemView: UIView {
    // MARK: - Initializer

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    // MARK: - Override

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }

    // MARK: - Private Methods

    private func setupView() {
        backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        layer.cornerRadius = 4.0
    }
}

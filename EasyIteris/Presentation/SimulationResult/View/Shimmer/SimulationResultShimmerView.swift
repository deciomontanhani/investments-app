//
//  SimulationResultShimmerView.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 24/09/19.
//

// MARK: - Imports
import UIKit

// MARK: - Protocols

// MARK: - Classes/Objects
class SimulationResultShimmerView: UIView {
    // MARK: IBOutlets
    @IBOutlet private weak var topView: UIView! {
        didSet {
            setup(shimmer: topView)
        }
    }

    // MARK: - private methods

    private func setup(shimmer: UIView) {
        shimmer.backgroundColor = UIColor.white
        shimmer.startShimmering()
    }
}

//
//  SimulationResultViewController.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 20/09/19.
//

import UIKit

class SimulationResultViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        title = Localizable.simulationFormTitle.localize()
    }

    static func instantiate() -> SimulationResultViewController {
        let viewController: SimulationResultViewController =
            SimulationResultViewController(nibName: String(describing: SimulationResultViewController.self), bundle: nil)
        return viewController
    }
}

//
//  SimulationFormViewController.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 20/09/19.
//

import UIKit

class SimulationFormViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        title = Localizable.simulationFormTitle.localize()

        UIFont.preferredFont(forTextStyle: .body)
    }

    static func instantiate() -> SimulationFormViewController {
        let viewController: SimulationFormViewController =
            SimulationFormViewController(nibName: String(describing: SimulationFormViewController.self), bundle: nil)
        return viewController
    }

    // MARK: - IBActions
    @IBAction func didTapSimulate(_ sender: UIButton) {
        navigationController?.pushViewController(SimulationResultViewController.instantiate(), animated: true)
    }
}

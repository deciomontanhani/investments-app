//
//  SimulationResultViewController.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 20/09/19.
//

import UIKit

class SimulationResultViewController: UIViewController, ViewCustomizable {
    typealias MainView = SimulationResultView

    var viewModel: SimulationResultViewModelProtocol?

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        title = Localizable.simulationFormTitle.localize()
    }

    static func instantiate(viewModel: SimulationResultViewModelProtocol = SimulationResultViewModel()) -> SimulationResultViewController {
        let viewController: SimulationResultViewController =
            SimulationResultViewController(nibName: SimulationResultViewController.className,
                                           bundle: nil)
        viewController.viewModel = viewModel
        return viewController
    }

    // MARK: - IBActions
    @IBAction private func didTapSimulateAgain(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

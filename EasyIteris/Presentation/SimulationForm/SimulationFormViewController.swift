//
//  SimulationFormViewController.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 20/09/19.
//

import UIKit

class SimulationFormViewController: UIViewController, ViewCustomizable {
    typealias MainView = SimulationFormView

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    // MARK: - Initializers
    static func instantiate() -> SimulationFormViewController {
        let viewController: SimulationFormViewController =
            SimulationFormViewController(nibName: SimulationFormViewController.className, bundle: nil)
        return viewController
    }

    private func setupView() {
        mainView.setupView()
        title = Localizable.simulationFormTitle.localize()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                           style: .plain,
                                                           target: nil,
                                                           action: nil)
    }

    // MARK: - IBActions
    @IBAction func didTapSimulate(_ sender: UIButton) {
        let viewModel = SimulationResultViewModel(queryObject: SimulationQueryRequest(investedAmount: 1_000,
                                                                                      rate: 100,
                                                                                      maturityDate: "2023-03-03"))
        navigationController?.pushViewController(SimulationResultViewController.instantiate(viewModel: viewModel),
                                                 animated: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    // MARK: - Private Methods
    // MARK: - Public Methods
}

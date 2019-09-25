//
//  SimulationResultViewController.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 20/09/19.
//

import UIKit

class SimulationResultViewController: UIViewController, ViewCustomizable {
    typealias MainView = SimulationResultView

    // MARK: - Properties
    var viewModel: SimulationResultViewModelProtocol?
    private lazy var shimmerView = SimulationResultShimmerView.fromNib(withOwner: self) as SimulationResultShimmerView?

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        title = Localizable.simulationFormTitle.localize()
        viewModel?.getSimulation()
        bindState()
    }

    // MARK: - Private Functions
    private func bindState() {
        viewModel?.viewState.bind { [weak self] state in
            switch state {
            case .loading:
                self?.handleLoading()
            case .error:
                self?.handleError()
            case .success:
                self?.handleLoaded()
            }
        }
    }

    private func handleError() {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: Localizable.errorTitle.localize(),
                                                    message: Constants.Messages.Unknown,
                                                    preferredStyle: .alert)

            alertController.addAction(UIAlertAction(title: Localizable.backButton.localize(),
                                                    style: .default,
                                                    handler: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }))

            self.present(alertController, animated: true)
        }
    }

    private func handleLoaded() {
        DispatchQueue.main.async {
            self.mainView.setupView(viewModel: self.viewModel?.simulationResult)
            self.shimmerView?.isHidden = true
        }
    }

    private func handleLoading() {
        shimmerView?.isHidden = false
        guard let shimmerViewUnw = shimmerView else {
            return
        }
        shimmerViewUnw.frame = view.bounds
        view.addSubview(shimmerViewUnw)
//        view.bringSubview(toFront: view)
    }

    static func instantiate(viewModel: SimulationResultViewModelProtocol) -> SimulationResultViewController {
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

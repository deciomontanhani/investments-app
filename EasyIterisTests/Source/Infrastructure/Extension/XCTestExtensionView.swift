//
//  EasyIterisTests.swift
//  EasyIterisTests
//
//  Created by Decio Montanhani on 20/09/19.
//

import UIKit
import XCTest

extension UIView {
    // MARK: - Public methods

    func viewWith<T: UIView>(accessibilityIdentifier identifier: String,
                             file: StaticString = #file,
                             line: UInt = #line) -> T {
        guard let view = viewWith(accessibilityIdentifier: identifier) else {
            XCTFail("view: \(identifier) was not found", file: file, line: line)
            return T()
        }

        guard let tempView = view as? T else {
            XCTFail("cast failed, expected \(String(describing: T.self)), but got \(type(of: view))",
                    file: file,
                    line: line)
            return T()
        }
        return tempView
    }

    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }

    // MARK: - Private methods

    private func viewWith(accessibilityIdentifier: String) -> UIView? {
        if self.accessibilityIdentifier == accessibilityIdentifier || accessibilityLabel == accessibilityIdentifier {
            return self
        }

        for subview in subviews {
            if let result = subview.viewWith(accessibilityIdentifier: accessibilityIdentifier) {
                return result
            }
        }
        return nil
    }
}

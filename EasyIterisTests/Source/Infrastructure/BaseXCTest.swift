//
//  EasyIterisTests.swift
//  EasyIterisTests
//
//  Created by Decio Montanhani on 20/09/19.
//

import FBSnapshotTestCase
import XCTest

class BaseXCTest: FBSnapshotTestCase {
    // MARK: - Public methods

    @available(*, deprecated)
    func verifySnapshotView(delay: TimeInterval = 0,
                            imageVerify: UIImage,
                            tolerance: CGFloat = 0,
                            identifier: String = "",
                            file: StaticString = #file,
                            line: UInt = #line) {
        if delay != 0 {
            Thread.sleep(forTimeInterval: delay)
        }

        folderName = customFolderName(file: file)
        let customIdentifier = cleanIdentifier(identifier: identifier)
        FBSnapshotVerifyView(UIImageView(image: imageVerify),
                             identifier: customIdentifier,
                             overallTolerance: tolerance,
                             file: file,
                             line: line)
    }

    func verifySnapshotView(delay: TimeInterval = 0,
                            tolerance: CGFloat = 0,
                            identifier: String = "",
                            file: StaticString = #file,
                            line: UInt = #line,
                            framesToRemove: [CGRect] = [],
                            view: @escaping () -> UIView?) {
        sleepTest(for: delay)

        guard let view = view() else {
            XCTFail("could not fetch view", file: file, line: line)
            return
        }

        var image = view.asImage()

        if !framesToRemove.isEmpty {
            image = image.addImageWithFrame(frames: framesToRemove) ?? UIImage()
        }

        folderName = customFolderName(file: file)
        let customIdentifier = "\(identifier)_\(UIDevice.current.name.replacingOccurrences(of: " ", with: ""))"
        FBSnapshotVerifyView(UIImageView(image: image),
                             identifier: customIdentifier,
                             perPixelTolerance: 0.005,
                             overallTolerance: tolerance,
                             file: file,
                             line: line)
    }

    func sleepTest(for delay: TimeInterval, file: StaticString = #file, line: UInt = #line) {
        guard delay > 0 else { return }
        let delayExpectation = XCTestExpectation(description: "failed to wait for " + String(delay))
        delayExpectation.assertForOverFulfill = true
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            delayExpectation.fulfill()
        }
        wait(for: [delayExpectation], timeout: 1 + delay)
    }

    // MARK: - Private methods

    private func cleanIdentifier(identifier: String) -> String {
        var deviceName = UIDevice.current.name

        if deviceName.contains("Clone") {
            for index in 0 ... 6 {
                deviceName = deviceName.replacingOccurrences(of: "Clone \(index) of", with: "")
            }
        }

        deviceName = deviceName.replacingOccurrences(of: " ", with: "")

        return "\(identifier)_\(deviceName)"
    }

    private func customFolderName(file: StaticString) -> String {
        let fileName = String(describing: type(of: self))
        let methodName: String = invocation?.selector.description ?? ""
        return "\(fileName)/\(methodName)"
    }
}

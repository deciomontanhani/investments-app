//
//  EasyIterisUITests.swift
//  EasyIterisUITests
//
//  Created by Decio Montanhani on 20/09/19.
//

import FBSnapshotTestCase
import XCTest

typealias Feature = FBSnapshotTestCase
typealias FeatureOperation = () -> Void
typealias CGRectDevices = (iPhone8: CGRect, iPhoneX: CGRect)

class BaseFeature: Feature {
    // MARK: - Constants

    let app = XCUIApplication()
    private let defaultLaunchArguments = ["UITest"]
    private let kMaxTolerance: CGFloat = 0.02

    // MARK: Overriding

    override func setUp() {
        super.setUp()
        continueAfterFailure = true
        XCUIDevice.shared.orientation = .portrait
        checkPermissionAlerts()
        HTTPDynamicStubs.shared.setUp()

        newLaunchArguments()
    }

    override func tearDown() {
        HTTPDynamicStubs.shared.tearDown()
        app.terminate()
        super.tearDown()
    }

    func newLaunchArguments(arguments: [String: Any]? = nil) {
        if app.state == .runningForeground {
            app.terminate()
        }
        app.launchArguments = defaultLaunchArguments
        arguments?.forEach {
            let argumentValue: String = "\(type(of: $0.value))<:>\($0.value)"
            let key: String = "UITest:\($0.key)"
            app.launchEnvironment[key] = argumentValue
        }
        app.launch()
    }

    // MARK: - BDT statements

    func given(_ description: String, _ operation: @escaping FeatureOperation) {
        performOperation(operation, description: "Given \(description)")
    }

    func when(_ description: String, _ operation: @escaping FeatureOperation) {
        performOperation(operation, description: "When \(description)")
    }

    func and(_ description: String, _ operation: @escaping FeatureOperation) {
        performOperation(operation, description: "And \(description)")
    }

    func then(_ description: String, _ operation: @escaping FeatureOperation) {
        performOperation(operation, description: "Then \(description)")
    }

    func framesByElementsToRemove(_ elements: [XCUIElement]) -> [CGRectDevices] {
        var rectsDevices: [CGRectDevices] = []
        for element in elements {
            let rectRemove = CGRect(x: element.frame.origin.x,
                                    y: element.frame.origin.y,
                                    width: element.frame.width,
                                    height: element.frame.height)
            rectsDevices.append((iPhone8: rectRemove, iPhoneX: rectRemove))
        }
        return rectsDevices
    }

    func verifySnapshotView(delay: TimeInterval = 0,
                            removeStatusBarTime: Bool = true,
                            tolerance: CGFloat = 0.000_1,
                            identifier: String = "",
                            file: StaticString = #file,
                            line: UInt = #line,
                            framesToRemove: [CGRectDevices] = []) {
        if tolerance > kMaxTolerance {
            XCTFail("tolerance of \(tolerance) is higher than the maximum allowed of \(kMaxTolerance)",
                    file: file,
                    line: line)
        }
        if delay != 0 {
            Thread.sleep(forTimeInterval: delay)
        }
        var image: UIImage? = app.screenshot().image
        if removeStatusBarTime {
            image = image?.removeStatusBar(with: app)
        }

        if !framesToRemove.isEmpty, let newImage = image {
            let frames = framesToRemove
                .map { UIDevice.current.name.contains(DeviceName.iPhone8.rawValue) ? $0.iPhone8: $0.iPhoneX }
            image = newImage.addImageWithFrame(frames: frames)
        }

        folderName = customFolderName(file: file)
        let customIdentifier = cleanIdentifier(identifier: identifier)
        FBSnapshotVerifyView(UIImageView(image: image),
                             identifier: customIdentifier,
                             suffixes: NSOrderedSet(array: ["_64"]),
                             perPixelTolerance: 0.005,
                             overallTolerance: tolerance,
                             file: file,
                             line: line)
    }

    // MARK: - Private Methods

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

    private func performOperation(_ operation: FeatureOperation, description: String) {
        XCTContext.runActivity(named: description) { _ in operation() }
    }

    private func checkPermissionAlerts() {
        addUIInterruptionMonitor(withDescription: "Location") { alert -> Bool in
            alert.buttons["Allow"].tapElement()
            return true
        }
        addUIInterruptionMonitor(withDescription: "Notifications") { alert -> Bool in
            alert.buttons["Allow"].tapElement()
            return true
        }
    }

    private func customFolderName(file: StaticString) -> String {
        let fileName = String(describing: type(of: self))
        let methodName: String = invocation?.selector.description ?? ""
        return "\(fileName)/\(methodName)"
    }
}

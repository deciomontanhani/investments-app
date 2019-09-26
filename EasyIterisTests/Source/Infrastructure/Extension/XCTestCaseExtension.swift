//  EasyIterisTests.swift
//  EasyIterisTests
//
//  Created by Decio Montanhani on 20/09/19.
//

import Foundation
import XCTest
@testable import EasyIteris

extension XCTestCase {
    // MARK: - Constants

    private static let expecteationDescription = "expectationFatalError"

    // MARK: - Public methods

    func expectFatalError(expectedMessage: String, testcase: @escaping () -> Void) {
        let expectation = self.expectation(description: XCTestCase.expecteationDescription)
        var assertionMessage: String?

        FatalErrorUtil.replaceFatalError { message, _, _ in
            assertionMessage = message
            expectation.fulfill()
            unreachable()
        }

        DispatchQueue.global(qos: .userInitiated).async(execute: testcase)

        waitForExpectations(timeout: 0.1) { _ in
            XCTAssertEqual(assertionMessage, expectedMessage)
            FatalErrorUtil.restoreFatalError()
        }
    }

    func decode<T>(jsonFileName: String, file: StaticString = #file, line: UInt = #line) -> T? where T: Decodable {
        var decodedJson: T?
        guard let data = LocalJsonReader.retrieveData(fromFile: jsonFileName) else {
            XCTFail("could not get \(jsonFileName) json", file: file, line: line)
            return nil
        }
        do {
            decodedJson = try JSONDecoder().decode(T.self, from: data)
        } catch {
            XCTFail("Decode fail with error: \(error)", file: file, line: line)
        }
        return decodedJson
    }
}

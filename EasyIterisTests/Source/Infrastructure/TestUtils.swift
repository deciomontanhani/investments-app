//
//  TestUtils.swift
//  EasyIteris
//
//

import Foundation

@objc
class TestUtils: NSObject {
    @objc
    static func JSONFromMock(resource: String) -> NSDictionary? {
        let bundle = Bundle(for: TestUtils.self)
        if let path = bundle.path(forResource: resource, ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                if let jsonResult: NSDictionary = try JSONSerialization
                    .jsonObject(with: jsonData,
                                options: .mutableContainers) as? NSDictionary {
                    return jsonResult
                }
            } catch {
                print("Error on method JSONFromMockWithResource")
            }
        }
        return nil
    }
}

//
//  EasyIterisUITests.swift
//  EasyIterisUITests
//
//  Created by Decio Montanhani on 20/09/19.
//

import Foundation
import Swifter
import XCTest

typealias DynamicStubParameterTuple = (queryString: String, fileName: String)?

class HTTPDynamicStubs {
    // MARK: - Properties

    private var server = HttpServer()
    static let shared = HTTPDynamicStubs()

    // MARK: - Public Methods

    public func setUp() {
        server = HttpServer()
        do {
            let port = serverPort()

            try server.start(in_port_t(port))
        } catch {
            XCTFail("serverStartFailed")
        }
    }

    public func tearDown() {
        server.stop()
    }

    public func setupStub(_ stubModel: HTTPStubModel,
                          httpRespose: HttpResponse? = nil,
                          file: StaticString = #file,
                          line: UInt = #line) {
        var response: (HttpRequest) -> HttpResponse
        if let httpRespose = httpRespose {
            response = { request in
                Thread.sleep(forTimeInterval: stubModel.delay)
                return httpRespose
            }
        } else {
            var data: Data
            if let modelData = stubModel.modelData {
                data = modelData
            } else {
                guard let jsonData = LocalJsonReader.retrieveData(fromFile: stubModel.jsonFilename) else {
                    XCTFail("Json cannot be retrieved from file", file: file, line: line)
                    return
                }
                data = jsonData
            }

            let json = dataToJSON(data: data, file: file, line: line)

            response = { request in
                Thread.sleep(forTimeInterval: stubModel.delay)
                if let headers = stubModel.headers {
                    let jsonObject = json as AnyObject

                    guard JSONSerialization.isValidJSONObject(jsonObject) else {
                        return HttpResponse.internalServerError
                    }
                    do {
                        let data = try JSONSerialization.data(withJSONObject: jsonObject)
                        return HttpResponse.raw(200, "OK", headers, { writer in
                            try writer.write(data)
                        })
                    } catch { return HttpResponse.internalServerError }
                } else {
                    return HttpResponse.ok(.json(json as AnyObject))
                }
            }
        }

        switch stubModel.method {
        case .GET:
            server.GET[stubModel.urlPath.rawValue] = response
        case .POST:
            server.POST[stubModel.urlPath.rawValue] = response
        case .PUT:
            server.PUT[stubModel.urlPath.rawValue] = response
        case .DELETE:
            server.DELETE[stubModel.urlPath.rawValue] = response
        }
    }

    // MARK: - Private Methods

    private init() {}

    private func serverPort() -> Int {
        let deviceName = UIDevice.current.name

        if deviceName.contains("Clone") {
            let range = deviceName.range(of: "Clone ")?.upperBound
            let device = deviceName[range! ..< deviceName.index(after: range!)]
            return 8_080 + Int(device)!
        }

        return 8_080
    }

    private static var httpStub: HTTPDynamicStubs = {
        let httpStub = HTTPDynamicStubs()
        return httpStub
    }()

    private func dataToJSON(data: Data, file: StaticString = #file, line: UInt = #line) -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        } catch {
            XCTFail("Json cannot be parsed error: \(error)", file: file, line: line)
        }
        return nil
    }
}

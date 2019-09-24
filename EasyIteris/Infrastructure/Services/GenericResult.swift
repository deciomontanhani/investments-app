//
//  GenericResult.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 23/09/19.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

extension Result {
    var isSuccess: Bool {
        switch self {
        case .success: return true
        case .failure: return false
        }
    }

    var item: T? {
        switch self {
        case .success(let item):
            return item
        default:
            return nil
        }
    }

    var error: Error? {
        switch self {
        case .failure(let error):
            return error
        default:
            return nil
        }
    }

    func map<N>(_ transform: (T) -> N?) -> Result<N> {
        guard self.isSuccess, let item = self.item, let result = transform(item) else {
            return Result<N>.failure(self.error ?? NSError(domain: "Unknown error", code: 0, userInfo: nil))
        }

        return Result<N>.success(result)
    }
}

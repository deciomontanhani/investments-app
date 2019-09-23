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

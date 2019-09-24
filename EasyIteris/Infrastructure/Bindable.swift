//
//  Bindable.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 24/09/19.
//

import Foundation

class Bindable<T> {
    typealias BindType = ((T) -> Void)

    // MARK: - Properties

    private var binds: [BindType] = []

    var value: T {
        didSet {
            execBinds()
        }
    }

    // MARK: - Initialize

    /// Initializer
    init(_ val: T) {
        value = val
    }

    // MARK: - Public Methods
    func bind(skip: Bool = false, _ bind: @escaping BindType) {
        binds.append(bind)
        if skip { return }
        bind(value)
    }

    // MARK: - Private Methods

    private func execBinds() {
        binds.forEach { [unowned self] bind in
            bind(self.value)
        }
    }
}

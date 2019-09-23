//
//  ViewCustomizable.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 23/09/19.
//

import UIKit

protocol ViewCustomizable {
    associatedtype MainView
}

extension ViewCustomizable where Self: UIViewController {
    var mainView: MainView {
        guard let mainView = view as? MainView else {
            fatalError("class not found")
        }
        return mainView
    }
}

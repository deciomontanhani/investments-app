//
//  EasyIterisUITests.swift
//  EasyIterisUITests
//
//  Created by Decio Montanhani on 20/09/19.
//

import UIKit

class MockCollectionViewController: UIViewController {
    var dequeue: ((IndexPath) -> UICollectionViewCell?)?
    var cellSize: ((IndexPath) -> CGSize)?
    var listSize: Int = 0
    var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        let flow = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect(x: 0,
                                                        y: 0,
                                                        width: view.frame.size.width,
                                                        height: view.frame.size.height),
                                          collectionViewLayout: flow)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        view.addSubview(collectionView!)
    }
}

extension MockCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize?(indexPath) ?? CGSize()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listSize
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dequeue?(indexPath) ?? UICollectionViewCell()
    }
}

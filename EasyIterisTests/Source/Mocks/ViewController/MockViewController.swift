//
//  EasyIterisUITests.swift
//  EasyIterisUITests
//
//  Created by Decio Montanhani on 20/09/19.
//

import UIKit

class MockViewController: UIViewController {
    var tableView: UITableView?
    var cellList: [UITableViewCell]? = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView()
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        tableView?.dataSource = self
        view.addSubview(tableView!)
    }

    func reloadData() {
        tableView?.reloadData()
    }
}

extension MockViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = cellList?[indexPath.row]
        if let height = item?.frame.size.height {
            tableView.estimatedRowHeight = height
            tableView.rowHeight = height
        }
        return item ?? UITableViewCell()
    }
}

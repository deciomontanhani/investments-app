//
//  EasyIterisUITests.swift
//  EasyIterisUITests
//
//  Created by Decio Montanhani on 20/09/19.
//

import UIKit

class MockTableViewController: UIViewController {
    var dequeueCell: ((IndexPath) -> UITableViewCell?)?
    var dequeueHeader: ((Int) -> UIView?)?
    var numberOfSections: Int = 1
    var listSize: Int = 0
    var cellHeight: CGFloat = 0
    var headerHeight: CGFloat = 0
    var tableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
        tableView?.dataSource = self
        tableView?.delegate = self
        view.addSubview(tableView!)
    }
}

extension MockTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSize
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return dequeueCell?(indexPath) ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return dequeueHeader?(section)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }
}

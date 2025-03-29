//
//  ViewController.swift
//  RxSwift_Beginners_TableViewFoodApp
//
//  Created by 邱慧珊 on 3/29/25.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITableViewDelegate {

    let tableViewItems = Observable.just(["Item 1", "Item 2", "Item 3", "Item 4"])
    let disposeBag = DisposeBag()
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        tableViewItems
            .bind(to: tableView
                .rx
                .items(cellIdentifier: "cell")) {
                      (tv, tableViewItem, cell) in
                    cell.textLabel?.text = tableViewItem
                }
                .disposed(by: disposeBag)
    }

    func setupTableView() {
        view.addSubview(tableView)

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}


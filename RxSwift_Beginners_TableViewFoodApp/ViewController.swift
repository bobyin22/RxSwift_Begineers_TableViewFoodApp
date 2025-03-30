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

    let tableViewItems = BehaviorRelay.init(value: [Food(name: "Hamburger", image: "hamburger"),
                                                    Food(name: "Pizza", image: "pizza"),
                                                    Food(name: "Salmon", image: "salmon"),
                                                    Food(name: "Spaghetti", image: "spaghetti"),
                                                    Food(name: "Club-sandwich", image: "club-sandwich"),
                                                    Food(name: "Curry", image: "curry"),
                                                    Food(name: "Salad cheese", image: "salad-cheese"),
                                                    Food(name: "Salad veggy", image: "salad-veg"),
                                                    Food(name: "Ribs", image: "ribs"),
                                                    Food(name: "Chana masala", image: "chana-masala"),
                                                    Food(name: "Pancakes", image: "pancakes"),
                                                    Food(name: "Tiramisu", image: "tiramisu"),
                                                    Food(name: "Cake", image: "cake")])
    let disposeBag = DisposeBag()
    
    let tableView = UITableView()
    let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Menu"
        setupSearchBar()
        setupTableView()
        
        let foodQuery = searchBar.rx.text.orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map({
                query in
                self.tableViewItems.value.filter({
                    food in
                    query.isEmpty || food.name.lowercased().contains(query.lowercased())
                })
            })
            .bind(to: tableView
            .rx
            .items(cellIdentifier: "cell", cellType: FoodTableViewCell.self)) {
                      (tv, tableViewItem, cell) in
                    cell.textLabel?.text = tableViewItem.name
                    cell.imageView?.image = UIImage(named: tableViewItem.image)
                }
            .disposed(by: disposeBag)
        
        tableView
            .rx.modelSelected(Food.self)
            .subscribe(onNext: {
                foodObject in
                let detailVC = DetailViewController()
                detailVC.imageName.accept(foodObject.image)
                self.navigationController?.pushViewController(detailVC, animated: true)
            })
            .disposed(by: disposeBag)
    }

    func setupSearchBar() {
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func setupTableView() {
        view.addSubview(tableView)

        tableView.register(FoodTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor), // 將 TableView 放在 SearchBar 下方
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}


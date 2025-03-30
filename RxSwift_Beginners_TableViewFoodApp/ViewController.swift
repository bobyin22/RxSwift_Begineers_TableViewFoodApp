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

    let tableViewItems = Observable.just([Food(name: "Hamburger", image: "hamburger"),
                                          Food(name: "Pizza", image: "pizza"),
                                          Food(name: "Salmon", image: "salmon"),
                                          Food(name: "Spaghetti", image: "spaghetti")])
    let disposeBag = DisposeBag()
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Menu"
        setupTableView()
        
        tableViewItems.bind(to: tableView
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
                detailVC.imageName = foodObject.image
                self.navigationController?.pushViewController(detailVC, animated: true)
            })
            .disposed(by: disposeBag)
        
//        tableView
//            .rx
//            .itemSelected
//            .subscribe(onNext: {
//                indexPath in
//            })
//            .disposed(by: disposeBag)
    }

    func setupTableView() {
        view.addSubview(tableView)

        tableView.register(FoodTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailVC = DetailViewController()
//        detailVC.imageName = "hamburger"
//        navigationController?.pushViewController(detailVC, animated: true)
//    }
    
}


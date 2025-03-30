//
//  DetailViewController.swift
//  RxSwift_Beginners_TableViewFoodApp
//
//  Created by 邱慧珊 on 3/29/25.
//

import UIKit

class DetailViewController: UIViewController {

    // 建立 UIImageView
    let foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // 用來接收圖片名稱的屬性
    var imageName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // 設定背景顏色
        view.backgroundColor = .white

        // 加入 foodImageView 並設定 Auto Layout
        view.addSubview(foodImageView)
        NSLayoutConstraint.activate([
            foodImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            foodImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            foodImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            foodImageView.heightAnchor.constraint(equalTo: foodImageView.widthAnchor)
        ])

        // 設定圖片
        foodImageView.image = UIImage(named: imageName)
    }
}

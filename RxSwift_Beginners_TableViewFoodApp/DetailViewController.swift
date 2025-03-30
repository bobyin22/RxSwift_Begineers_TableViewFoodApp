//
//  DetailViewController.swift
//  RxSwift_Beginners_TableViewFoodApp
//
//  Created by 邱慧珊 on 3/29/25.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {

    // 建立 UIImageView
    let foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // 用來接收圖片名稱的屬性
    //var imageName: String = ""
    let imageName = BehaviorRelay<String>(value: "")
    let disposeBag2 = DisposeBag()

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
        //foodImageView.image = UIImage(named: imageName)
        imageName
            .map({
                name in
                UIImage(named: name)
            })
            .bind(to: foodImageView
                .rx
                .image)
            .disposed(by: disposeBag2)
    }
}


/*
 // Replay Subject
 let rSub = ReplaySubject<Int>.create(bufferSize: 3)
 rSub.onNext(1)
 rSub.onNext(2)
 rSub.onNext(3)

 //let ob3 = rSub.subscribe(onNext: { //會印出1 2 3
 //    elm in
 //    print(elm)
 //})
 
 

 let ob3 = rSub.map({   //會印出2 4 6
     elem in
     elem * 2
 }).subscribe(onNext: {
     elm in
     print(elm)
 })
 */

//
//  TableViewCell.swift
//  RxSwift_Beginners_TableViewFoodApp
//
//  Created by 邱慧珊 on 3/29/25.
//

import UIKit

class FoodTableViewCell: UITableViewCell {

    // 建立 UI 元件
    let foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let foodLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        // 將 UI 元件加入到 contentView
        contentView.addSubview(foodImageView)
        contentView.addSubview(foodLabel)

        // 設定 Auto Layout
        NSLayoutConstraint.activate([
            // foodImageView 的約束
            foodImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            foodImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            foodImageView.widthAnchor.constraint(equalToConstant: 50),
            foodImageView.heightAnchor.constraint(equalToConstant: 50),

            // foodLabel 的約束
            foodLabel.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: 10),
            foodLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            foodLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

//
//  LoginViewController.swift
//  RxSwift_Beginners_TableViewFoodApp
//
//  Created by 邱慧珊 on 3/31/25.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    // 建立 UI 元素
    let userNameTf: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your number"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let passwordTf: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let disposeBag3 = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // 添加 UI 元素到視圖
        view.addSubview(userNameTf)
        view.addSubview(passwordTf)
        view.addSubview(loginButton)

        // 設置 Auto Layout
        setupConstraints()
        
        let observable1 = self.userNameTf.rx.text.orEmpty
        let observable2 = self.passwordTf.rx.text.orEmpty
        let observableCombined = Observable.combineLatest(observable1, observable2)
        
        self.loginButton.rx.tap
            .withLatestFrom(observableCombined)
            .subscribe(onNext: {
                self.login(user: $0, pass: $1)
            })
            .disposed(by: disposeBag3)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // numberNameTf 的約束
            userNameTf.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            userNameTf.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userNameTf.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            userNameTf.heightAnchor.constraint(equalToConstant: 40),

            // passwordNameTf 的約束
            passwordTf.topAnchor.constraint(equalTo: userNameTf.bottomAnchor, constant: 20),
            passwordTf.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTf.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTf.heightAnchor.constraint(equalToConstant: 40),

            // loginButton 的約束
            loginButton.topAnchor.constraint(equalTo: passwordTf.bottomAnchor, constant: 30),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func login(user: String, pass: String) {
        // 驗證使用者名稱是否符合電子郵件格式
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES[c] %@", emailRegEx)
        let emailValid: Bool = emailTest.evaluate(with: user)

        // 驗證密碼是否有效（非空且長度大於等於 6）
        let passValid: Bool = (pass != "" && pass.count >= 6)

        if (emailValid && passValid) {
            // 如果帳號和密碼有效，導航到 FoodListVC
            let foodListVC = ViewController()
            self.navigationController?.pushViewController(foodListVC, animated: true)
        } else {
            // 如果帳號或密碼無效，顯示錯誤提示
            // 顯示錯誤提示
            let alert = UIAlertController(title: "Wrong credentials",
                                          message: "Please enter a valid username and password",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

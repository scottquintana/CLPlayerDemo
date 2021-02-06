//
//  LoginViewController.swift
//  ConchaLabsPlayerDemo
//
//  Created by Scott Quintana on 2/6/21.
//

import UIKit

class LoginViewController: UIViewController {

    let loginView = LoginView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loginView.delegate = self
        configureLoginView()
    }

    private func configureLoginView() {
        view.addSubview(loginView)
        
        loginView.layer.cornerRadius = 16
        
        NSLayoutConstraint.activate([
            loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.widthAnchor.constraint(equalToConstant: (view.frame.width - 50)),
            loginView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func signInUser(email: String, password: String) {
       print("signing in")
    }

}

extension LoginViewController: LoginViewDelegate {
    func didPressLogin(email: String, password: String) {
        signInUser(email: email, password: password)
    }
}

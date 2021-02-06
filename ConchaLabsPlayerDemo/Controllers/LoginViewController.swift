//
//  LoginViewController.swift
//  ConchaLabsPlayerDemo
//
//  Created by Scott Quintana on 2/6/21.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {

    let signInButton = GIDSignInButton()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        configureLoginView()
    }

    private func configureLoginView() {
        view.addSubview(signInButton)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    

}

// MARK: - Google Login Extension

extension LoginViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
          print(error.localizedDescription)
          return
        }
        
        let playerViewController = PlayerViewController()
        navigationController?.pushViewController(playerViewController, animated: true)
    }
}

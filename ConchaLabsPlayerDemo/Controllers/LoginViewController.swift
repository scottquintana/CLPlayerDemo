//
//  LoginViewController.swift
//  ConchaLabsPlayerDemo
//
//  Created by Scott Quintana on 2/6/21.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {
    
    let titleLabel = CLTitleLabel(textAlignment: .center, fontSize: 32, fontColor: .black)
    let bodyLabel = CLBodyLabel(textAlignment: .center, fontSize: 16, fontColor: .black)
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
        view.addSubview(titleLabel)
        view.addSubview(bodyLabel)
        
        titleLabel.text = "Welcome!"
        bodyLabel.text = "Please sign in below using your Google account."
        
        let padding: CGFloat = 10
        let spacing: CGFloat = 30
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 36),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            titleLabel.bottomAnchor.constraint(equalTo: bodyLabel.topAnchor, constant: -spacing),
            
            bodyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            bodyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            bodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            bodyLabel.heightAnchor.constraint(equalToConstant: 20),
            
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: spacing),
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
        
        let playerViewController = PlayerViewController(audioPlayer: CLAudioPlayer(), user: user.profile.givenName)
        navigationController?.pushViewController(playerViewController, animated: true)
    }
}

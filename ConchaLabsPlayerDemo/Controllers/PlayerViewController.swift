//
//  PlayerViewController.swift
//  ConchaLabsPlayerDemo
//
//  Created by Scott Quintana on 2/5/21.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    var audioSessionObserver: Any!
    var greetingLabel: CLTitleLabel!
    let playerView = PlayerView()
    var audioPlayer: AudioPlayer!
    var bluetoothButton = CLButton(title: "BLUETOOTH SETTINGS", backgroundColor: Colors.gold)
    
    var user = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.cream

        greetingLabel = CLTitleLabel(textAlignment: .center, fontSize: 32, fontColor: Colors.lightGrey)
        greetingLabel.text = "Hello, \(user)!"
        playerView.delegate = self
        
        configureNavbar()
        configurePlayer()
        observer()
    }
    
    
    convenience init(audioPlayer: AudioPlayer, user: String) {
        self.init()
        self.audioPlayer = audioPlayer
        self.user = user
    }
    
    
    private func configureNavbar() {
        title = "CL Player"
        self.navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.navigationBar.isTranslucent = false
    }
    
    
    private func configurePlayer() {
        view.addSubviews(greetingLabel, playerView, bluetoothButton)
        
        playerView.translatesAutoresizingMaskIntoConstraints = false
        
        bluetoothButton.addTarget(self, action: #selector(presentBTSettings), for: .touchUpInside)
        
        let padding: CGFloat = 4
        
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            greetingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            greetingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            greetingLabel.bottomAnchor.constraint(equalTo: playerView.topAnchor, constant: -padding),
            
            playerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            playerView.heightAnchor.constraint(equalToConstant: 250),
            
            bluetoothButton.topAnchor.constraint(equalTo: playerView.bottomAnchor, constant: 30),
            bluetoothButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bluetoothButton.widthAnchor.constraint(equalToConstant: 170),
            bluetoothButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    
    func startAudio() {
        audioPlayer.playPause()
    }
    
    
    @objc func presentBTSettings() {
        UIApplication.shared.open(URL(string: "App-prefs:Bluetooth")!)
    }
    
    
    func observer() {
        let notificationCenter = NotificationCenter.default
        
        audioSessionObserver = notificationCenter.addObserver(forName: AVAudioSession.routeChangeNotification, object: nil, queue: nil) { [weak self] _ in
            guard let self = self else { return }
            
            self.playerView.playPauseButton.isSelected = false
        }
    }
}


extension PlayerViewController: PlayerViewDelegate {
    func togglePlayPause() {
        audioPlayer.playPause()
    }
    
    
    func volumeDidChange(to volume: Float) {
        audioPlayer.setVolume(volume)
    }
}

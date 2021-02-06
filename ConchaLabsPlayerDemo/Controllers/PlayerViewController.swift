//
//  PlayerViewController.swift
//  ConchaLabsPlayerDemo
//
//  Created by Scott Quintana on 2/5/21.
//

import UIKit

class PlayerViewController: UIViewController {
    
    let playerView = PlayerView()
    var audioPlayer: AudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.cream
        audioPlayer = CLAudioPlayer()
        playerView.delegate = self
        configurePlayer()
    }

    private func configurePlayer() {
        view.addSubview(playerView)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 4
        
        NSLayoutConstraint.activate([
            playerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            playerView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    func startAudio() {
        audioPlayer.playPause()
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

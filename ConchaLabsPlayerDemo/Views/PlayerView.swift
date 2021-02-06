//
//  PlayerView.swift
//  ConchaLabsPlayerDemo
//
//  Created by Scott Quintana on 2/5/21.
//

import UIKit

protocol PlayerViewDelegate: class {
    func togglePlayPause()
    func volumeDidChange(to volume: Float)
}

class PlayerView: UIView {
    let defaults = UserDefaults.standard
    let playPauseButton = CLPlayPauseButton()
    let volumeControlView = VolumeControlView()
    weak var delegate: PlayerViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .brown
        volumeControlView.delegate = self
        configureVolumeControl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureVolumeControl() {
        addSubview(playPauseButton)
        addSubview(volumeControlView)
        playPauseButton.addTarget(self, action: #selector(playPauseTapped), for: .touchUpInside)
        volumeControlView.volumeSlider.value = defaults.object(forKey: "volume") as? Float ?? 0.5
        volumeControlView.translatesAutoresizingMaskIntoConstraints = false
        
        volumeControlView.layer.cornerRadius = (30)
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            playPauseButton.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            playPauseButton.widthAnchor.constraint(equalToConstant: 100),
            playPauseButton.heightAnchor.constraint(equalToConstant: 100),
            playPauseButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            volumeControlView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            volumeControlView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            volumeControlView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            volumeControlView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc private func playPauseTapped() {
        delegate?.togglePlayPause()
        playPauseButton.isSelected.toggle()
    }
}

extension PlayerView: VolumeControlViewDelegate {
    func didChangeVolume(to volume: Float) {
        delegate?.volumeDidChange(to: volume)
    }
}
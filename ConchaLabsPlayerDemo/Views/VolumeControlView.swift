//
//  VolumeControlView.swift
//  ConchaLabsPlayerDemo
//
//  Created by Scott Quintana on 2/5/21.
//

import UIKit

protocol VolumeControlViewDelegate: class {
    func didChangeVolume(to volume: Float)
}

class VolumeControlView: UIView {

    let lowSpeakerImage = UIImageView(image: SFSymbols.speakerLow)
    let highSpeakerImage = UIImageView(image: SFSymbols.speakerHigh)
    let volumeSlider = CLSlider()
    
    weak var delegate: VolumeControlViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutUI() {
        addSubview(lowSpeakerImage)
        addSubview(highSpeakerImage)
        addSubview(volumeSlider)
        
        lowSpeakerImage.translatesAutoresizingMaskIntoConstraints = false
        highSpeakerImage.translatesAutoresizingMaskIntoConstraints = false
        
        lowSpeakerImage.tintColor = Colors.darkGrey
        highSpeakerImage.tintColor = Colors.darkGrey
        
        volumeSlider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        
        backgroundColor = .white
        
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            lowSpeakerImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            lowSpeakerImage.widthAnchor.constraint(equalToConstant: 30),
            lowSpeakerImage.heightAnchor.constraint(equalToConstant: 30),
            lowSpeakerImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            highSpeakerImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            highSpeakerImage.widthAnchor.constraint(equalToConstant: 40),
            highSpeakerImage.heightAnchor.constraint(equalToConstant: 30),
            highSpeakerImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            volumeSlider.leadingAnchor.constraint(equalTo: lowSpeakerImage.trailingAnchor, constant: padding),
            volumeSlider.trailingAnchor.constraint(equalTo: highSpeakerImage.leadingAnchor, constant: -padding),
            volumeSlider.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            volumeSlider.heightAnchor.constraint(equalToConstant: 50)   
        ])
    }
    
    @objc private func sliderChanged() {
        delegate?.didChangeVolume(to: volumeSlider.value)
    }
}

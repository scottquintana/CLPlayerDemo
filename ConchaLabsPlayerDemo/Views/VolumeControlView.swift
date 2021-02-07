//
//  VolumeControlView.swift
//  ConchaLabsPlayerDemo
//
//  Created by Scott Quintana on 2/5/21.
//

import UIKit
import AVKit

protocol VolumeControlViewDelegate: class {
    func didChangeVolume(to volume: Float)
}

class VolumeControlView: UIView {

    let speakerImage = UIImageView()
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
        backgroundColor = .white
        
        let routePickerView = AVRoutePickerView()
        routePickerView.translatesAutoresizingMaskIntoConstraints = false
        addSubviews(speakerImage, routePickerView, volumeSlider)
        
        speakerImage.translatesAutoresizingMaskIntoConstraints = false
        
        speakerImage.contentMode = .left
        speakerImage.tintColor = Colors.darkGrey
        routePickerView.tintColor = Colors.darkGrey
        setSpeakerImage(volumeSlider.value)
        volumeSlider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            speakerImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            speakerImage.widthAnchor.constraint(equalToConstant: 25),
            speakerImage.heightAnchor.constraint(equalToConstant: 30),
            speakerImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            routePickerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            routePickerView.widthAnchor.constraint(equalToConstant: 30),
            routePickerView.heightAnchor.constraint(equalToConstant: 30),
            routePickerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            volumeSlider.leadingAnchor.constraint(equalTo: speakerImage.trailingAnchor, constant: padding),
            volumeSlider.trailingAnchor.constraint(equalTo: routePickerView.leadingAnchor, constant: -padding),
            volumeSlider.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            volumeSlider.heightAnchor.constraint(equalToConstant: 50)   
        ])
    }
    
    
    @objc private func sliderChanged() {
        delegate?.didChangeVolume(to: volumeSlider.value)
        setSpeakerImage(volumeSlider.value)
    }
    
    func setSpeakerImage(_ volume: Float) {
        switch volume {
        case 0.0:
            speakerImage.image = SFSymbols.speakerOff
        case 0.01..<0.33:
            speakerImage.image = SFSymbols.speakerLow
        case 0.33..<0.66:
            speakerImage.image = SFSymbols.speakerMed
        case 0.66...1.0:
            speakerImage.image = SFSymbols.speakerHigh
        default:
            speakerImage.image = SFSymbols.speakerMed
        }
    }
}

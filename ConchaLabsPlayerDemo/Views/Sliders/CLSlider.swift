//
//  CLSlider.swift
//  ConchaLabsPlayerDemo
//
//  Created by Scott Quintana on 2/5/21.
//

import UIKit

class CLSlider: UISlider {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        minimumValue = 0
        maximumValue = 1
        minimumTrackTintColor = Colors.gold
        maximumTrackTintColor = .gray
    }
}

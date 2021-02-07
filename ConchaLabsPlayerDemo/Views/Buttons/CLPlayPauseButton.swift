//
//  CLPlayPauseButton.swift
//  ConchaLabsPlayerDemo
//
//  Created by Scott Quintana on 2/5/21.
//

import UIKit

class CLPlayPauseButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        setImage(SFSymbols.play, for: .normal)
        setImage(SFSymbols.pause, for: .selected)
        imageView?.tintColor = Colors.gold
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        layer.cornerRadius =  bounds.size.width / 2
        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowOpacity = 0.50
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 3
        clipsToBounds = false
    }
    
}

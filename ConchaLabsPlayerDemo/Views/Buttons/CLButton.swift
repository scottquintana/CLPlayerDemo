//
//  CLButton.swift
//  ConchaLabsPlayerDemo
//
//  Created by Scott Quintana on 2/6/21.
//

import UIKit

class CLButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    convenience init(title: String, backgroundColor: UIColor) {
        self.init(frame: .zero)
        setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 20
        setTitleColor(.black, for: .normal)
        titleLabel?.font = UIFont(name: Fonts.nunitoSans, size: 12)
    }
    
    
    func set(backgroundColor: UIColor, title: String) {
        setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
    }
}

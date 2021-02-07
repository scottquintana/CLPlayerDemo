//
//  CLBodyLabel.swift
//  ConchaLabsPlayerDemo
//
//  Created by Scott Quintana on 2/6/21.
//

import UIKit

class CLBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat, fontColor: UIColor) {
        self.init(frame: .zero)
        font = UIFont(name: Fonts.nunitoSans, size: fontSize)
        textColor = fontColor
        self.textAlignment = textAlignment
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        numberOfLines = 4
    }

}

//
//  GradientView.swift
//  ConchaLabsPlayerDemo
//
//  Created by Scott Quintana on 2/7/21.
//

import UIKit

class GradientView: UIView {

    private var color1: CGColor = Colors.cream.cgColor
    private var color2: CGColor = Colors.cream.cgColor

    convenience init(cgColor1: CGColor, cgColor2: CGColor) {
        self.init(frame: .zero)
        color1 = cgColor1
        color2 = cgColor2
    }
    
    
    override func layoutSubviews() {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [color1, color2]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        self.layer.insertSublayer(gradient, at: 0)
    }
}

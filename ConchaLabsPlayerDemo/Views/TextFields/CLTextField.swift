//
//  CLTextField.swift
//  ConchaLabsPlayerDemo
//
//  Created by Scott Quintana on 2/6/21.
//

import UIKit

class CLTextField: UITextField {
    
    var textPadding = UIEdgeInsets(
        top: 2,
        left: 10,
        bottom: 2,
        right: 10
    )

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
       
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 6
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        
        return rect.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        
        return rect.inset(by: textPadding)
    }

}

//
//  UIViewController+ensureMainQueue.swift
//  ConchaLabsPlayerDemo
//
//  Created by Scott Quintana on 2/8/21.
//

import UIKit

extension UIViewController {
    func ensureMainQueue(using closure: @escaping () -> Void) {
        if Thread.isMainThread {
            closure()
        } else {
            DispatchQueue.main.async(execute: closure)
        }
    }
}

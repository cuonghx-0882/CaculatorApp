//
//  Extension.swift
//  Caculator app
//
//  Created by cuonghx on 4/8/19.
//  Copyright © 2019 cuonghx. All rights reserved.
//
import UIKit

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        self.clipsToBounds = true  // add this to maintain corner radius
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}
extension Double {
    func toString() -> String {
        return String (self)
    }
}

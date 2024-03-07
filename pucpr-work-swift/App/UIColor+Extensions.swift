//
//  UIColor+Extensions.swift
//  Trabalho de ios
//
//  Created by user240648 on 3/6/24.
//

import Foundation
import UIKit

extension UIColor {
    static var rosaclaro: UIColor {
        return UIColor(red: 0.91, green:0.81, blue: 0.90, alpha:1.0)
    }
    static var rosaescuro: UIColor {
        return UIColor(red: 0.91, green:0, blue: 0.87, alpha:1.0)
    }
    static var backgroundGray: UIColor {
        return UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.0)
    }
}

extension CAGradientLayer {
    static func customGradientLayer() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0.9176, green: 0.6588, blue: 0.9059, alpha: 1.0).cgColor,
            UIColor(red: 0.9176, green: 0, blue: 0.8706, alpha: 1.0).cgColor,
            UIColor(red: 0.9176, green: 0.6588, blue: 0.9059, alpha: 1.0).cgColor
        ]

        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)

        gradientLayer.locations = [0.4, 0.6, 1.0]

        return gradientLayer
    }
}

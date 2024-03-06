// UIColor+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIColor {
    static var colorStore: [String: UIColor] = [:]
    class func rgba(
        _ red: CGFloat,
        _ green: CGFloat,
        _ blue: CGFloat,
        _ alpha: CGFloat
    ) -> UIColor {
        let key = "\(red)\(green)\(blue)\(alpha)"
        if let color = colorStore[key] {
            return color
        }
        let color = UIColor(
            red: red,
            green: green,
            blue: blue,
            alpha: alpha
        )
        colorStore[key] = color
        return color
    }
}

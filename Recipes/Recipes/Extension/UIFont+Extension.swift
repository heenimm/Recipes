// UIFont+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIFont {
    private static var fontCache = [String: UIFont]()

    static func cachedFont(name: String, size: CGFloat) -> UIFont {
        let fontKey = "\(name)\(size)"

        if let cachedFont = fontCache[fontKey] {
            return cachedFont

        } else {
            let font = UIFont(name: name, size: size)!
            fontCache[fontKey] = font
            return font
        }
    }

    static let Verdana8 = UIFont(name: "Verdana", size: 8)
    static let Verdana10 = UIFont(name: "Verdana", size: 10)
    static let Verdana12 = UIFont(name: "Verdana", size: 12)
    static let Verdana14 = UIFont(name: "Verdana", size: 14)
    static let Verdana16 = UIFont(name: "Verdana", size: 16)
    static let Verdana18 = UIFont(name: "Verdana", size: 18)
    static let Verdana24 = UIFont(name: "Verdana", size: 24)
    static let VerdanaBold10 = UIFont(name: "Verdana-Bold", size: 10)
    static let VerdanaBold12 = UIFont(name: "Verdana-Bold", size: 12)
    static let VerdanaBold14 = UIFont(name: "Verdana-Bold", size: 14)
    static let VerdanaBold16 = UIFont(name: "Verdana-Bold", size: 16)
    static let VerdanaBold18 = UIFont(name: "Verdana-Bold", size: 18)
    static let VerdanaBold20 = UIFont(name: "Verdana-Bold", size: 20)
    static let VerdanaBold24 = UIFont(name: "Verdana-Bold", size: 24)
    static let VerdanaBold26 = UIFont(name: "Verdana-Bold", size: 26)
    static let VerdanaBold28 = UIFont(name: "Verdana-Bold", size: 28)
}

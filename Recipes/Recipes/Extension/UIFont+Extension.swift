// UIFont+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIFont {
    
    private static var fontCache = [String: UIFont]()
    
    static func cachedFont(name: String, size: CGFloat) -> UIFont {
        
        let fontKey = "\(name)-\(size)"
        
        if let cachedFont = fontCache[fontKey] {
            
            return cachedFont
            
        } else {
            
            let font = UIFont(name: name, size: size)!
            
            fontCache[fontKey] = font
            
            return font
            
        }
        
    }
    
}

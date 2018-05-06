//
//  UIColor+Ext.swift
//  RectangleApp
//
//  Created by Anna on 05.05.2018.
//  Copyright © 2018 Anna Lutsenko. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let customColors = [UIColor.init(hex: "228AE6"),
                  UIColor.init(hex: "16AABF"),
                  UIColor.init(hex: "41C057"),
                  UIColor.init(hex: "FAB005"),
                  UIColor.init(hex: "FD7E13"),
                  UIColor.init(hex: "FA5251"),
                  UIColor.init(hex: "FF43AD"),
                  UIColor.init(hex: "BE4ADB")]
    
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    class func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
        let maxValue : CGFloat = 255
        return UIColor(red: r / maxValue, green: g / maxValue, blue: b / maxValue, alpha: a)
    }
    
    class func getRandomColor() -> UIColor? {
        return UIColor.customColors.randomItem()
    }
    
    open class var customGrey : UIColor {
        return UIColor.rgba(193, 193, 193, 1)
    }
    
}

fileprivate extension Array {
    func randomItem() -> Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

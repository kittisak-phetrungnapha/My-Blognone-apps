//
//  MyColorExtension.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/25/2559 BE.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static let navigationBarBackground = "#38649d"
    static let refreshViewBackground = "#569044"
    static let errorViewBackground = navigationBarBackground
    static let highLightNewsListCellBackground = refreshViewBackground
    
    static func defaultNavigationBarColor() -> UIColor {
        return UIColor(colorLiteralRed: (247/255), green: (247/255), blue: (247/255), alpha: 1)
    }
    
    convenience init?(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return nil
        }
        
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
}

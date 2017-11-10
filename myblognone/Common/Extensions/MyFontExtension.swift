//
//  MyFontExtension.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/25/2559 BE.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    private enum MyFont: String {
        case SFUIDisplayBold = "SFUIDisplay-Bold"
        case SFUITextLight = "SFUIText-Light"
        case SFUITextRegular = "SFUIText-Regular"
        case SFUIDisplayMedium = "SFUIDisplay-Medium"
    }
    private static let defaultFont = UIFont.systemFont(ofSize: 17)
    
    static func printAllPossibleFonts() {
        UIFont.familyNames.sorted().forEach({
            UIFont.fontNames(forFamilyName: $0).sorted().forEach({
                print($0)
            })
        })
    }
    
    static func fontForNavigationBarTitle() -> UIFont {
        return UIFont(name: MyFont.SFUIDisplayMedium.rawValue, size: 21) ?? defaultFont
    }
    
    static func fontForLargeNavigationBarTitle() -> UIFont {
        return UIFont(name: MyFont.SFUIDisplayMedium.rawValue, size: 32) ?? defaultFont
    }
    
    static func fontForNewsTitle() -> UIFont {
        return UIFont(name: MyFont.SFUIDisplayBold.rawValue, size: 21) ?? defaultFont
    }
    
    static func fontForNewsCreator() -> UIFont {
        return UIFont(name: MyFont.SFUITextLight.rawValue, size: 17) ?? defaultFont
    }
    
    static func fontForNewsPubDate() -> UIFont {
        return UIFont(name: MyFont.SFUITextRegular.rawValue, size: 15) ?? defaultFont
    }
    
    static func fontFotLastUpdateTime() -> UIFont {
        return UIFont(name: MyFont.SFUITextLight.rawValue, size: 14) ?? defaultFont
    }
    
    static func fontForVersionTitle() -> UIFont {
        return UIFont(name: MyFont.SFUITextRegular.rawValue, size: 17) ?? defaultFont
    }
    
    static func fontForVersionValue() -> UIFont {
        return UIFont(name: MyFont.SFUITextRegular.rawValue, size: 17) ?? defaultFont
    }
    
    static func fontForSendEmailFeedback() -> UIFont {
        return UIFont(name: MyFont.SFUITextRegular.rawValue, size: 17) ?? defaultFont
    }
    
    static func fontForRateApps() -> UIFont {
        return UIFont(name: MyFont.SFUITextRegular.rawValue, size: 17) ?? defaultFont
    }
    
}

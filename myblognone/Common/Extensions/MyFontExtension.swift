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
    
    static func printAllPossibleFonts() {
        UIFont.familyNames.sorted().forEach({
            UIFont.fontNames(forFamilyName: $0).sorted().forEach({
                print($0)
            })
        })
    }
    
}

//
//  MyDateExtension.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/22/2559 BE.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import Foundation

extension Date {
    
    func getStringWith(format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
}

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
        formatter.timeZone = TimeZone(secondsFromGMT: 25200)
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: self)
    }
    
    static func getNewDateTimeString(inputStr: String, inputFormat: String, outputFormat: String) -> String? {
        // input
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 25200)
        formatter.dateFormat = inputFormat
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        guard let inputDate = formatter.date(from: inputStr) else {
            return nil
        }
        
        // output
        formatter.dateFormat = outputFormat
        return formatter.string(from: inputDate)
    }
}

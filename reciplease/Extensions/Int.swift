//
//  Int.swift
//  reciplease
//
//  Created by Mosma on 27/03/2021.
//

import Foundation

extension Int {
    var convertTimeToString: String {
        if self == 0 {
            let timeNull = "N/A"
            return timeNull
        } else {
            let minutes = self % 60
            let hours = self / 60
            let timeFormatString = String(format: "%01dh%02d", hours, minutes)
            let timeFormatStringMin = String(format: "%02dm", minutes)
            let timeFormatNoMin = String(format: "%01dh", hours)
            let timeFormatStringLessTenMin = String(format: "%01dm", minutes)
            if self < 60 {
                if minutes < 10 {
                    return timeFormatStringLessTenMin
                }
                return timeFormatStringMin
            } else if minutes == 0 {
                return timeFormatNoMin
            } else {
                return timeFormatString
            }
        }
    }
}

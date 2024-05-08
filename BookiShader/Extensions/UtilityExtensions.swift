/*
 UtilityExtensions.swift
 Book iShader

 Created by Treata Norouzi on 5/8/24.
*/

import Foundation

// MARK: - TimeInterval

extension TimeInterval {
    func rounded(toDecimalPlaces decimalPlaces: Int) -> TimeInterval {
        let multiplier = pow(10.0, Double(decimalPlaces))
        return (self * multiplier).rounded() / multiplier
    }

    func truncated(toDecimalPlaces decimalPlaces: Int) -> TimeInterval {
        let multiplier = pow(10.0, Double(decimalPlaces))
        return TimeInterval(Int(self * multiplier)) / multiplier
    }
}

// MARK: - String

extension String {
    var spacedOut: String {
        var spacedString = ""
        
        var skipFirst = false
        for character in self {
            if character.isUppercase && !skipFirst {
                skipFirst = true
            } else if character.isUppercase {
                spacedString += " "
            }
            
            spacedString += String(character)
        }
        
        return spacedString
    }
}

/*
 Extension+TimeInterval.swift
 Book iShader

 Created by Treata Norouzi on 4/9/24.
*/

import Foundation

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


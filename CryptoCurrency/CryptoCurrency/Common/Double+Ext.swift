//
//  Double+Ext.swift
//  CryptoCurrency
//
//  Created by Ana Carolina Martins Pessoa on 15/02/22.
//

import Foundation
extension Double {
    
    /// Converts a Double into a Currency with 2 decimal places
    ///```
    ///Convert 1234.56 to $1,234.56
    ///```
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        //formatter.locale = .current // <- default value
        //formatter.currencyCide = "usd" // <- change currency
        formatter.currencySymbol = "$"   // <- change currency symbol
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    ///Converts a Double into a Currency as a String with 2-6 decimal places
    ///```
    ///Convert 1234.56 to "$1,234.56"
    ///Convert 12.3456 to "$12.3456"
    ///Convert 0.123456 to "$0.123456"
    ///```
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$ 0.00"
    }
}

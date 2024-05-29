//
//  Conversor.swift
//  BRBankSlipChecker
//
//  Created by Matheus Gois on 28/05/24.
//

import Foundation

enum Converter {
    static func convertToPaymentSlipBarcode(_ code: String) -> String {
        let cleanedCode = Utils.clearMask(code)
        var barcode = ""
        for index in 0..<4 {
            let startIndex = cleanedCode.index(cleanedCode.startIndex, offsetBy: (11 * index) + index)
            let endIndex = cleanedCode.index(startIndex, offsetBy: 11)
            let range = startIndex..<endIndex
            barcode += String(cleanedCode[range])
        }
        return barcode
    }

    static func convertToBankSlipBarcode(_ code: String) -> String {
        let cleanedCode = Utils.clearMask(code)
        var barcode = ""
        barcode += String(cleanedCode.prefix(3)) // Bank identification
        barcode += String(cleanedCode[cleanedCode.index(cleanedCode.startIndex, offsetBy: 3)]) // Currency code
        barcode += String(cleanedCode[cleanedCode.index(cleanedCode.startIndex, offsetBy: 32)]) // DV
        barcode += String(cleanedCode[cleanedCode.index(cleanedCode.startIndex, offsetBy: 33)..<cleanedCode.index(cleanedCode.startIndex, offsetBy: 37)]) // Due date factor
        barcode += String(cleanedCode[cleanedCode.index(cleanedCode.startIndex, offsetBy: 37)..<cleanedCode.index(cleanedCode.startIndex, offsetBy: 47)]) // Nominal value
        barcode += String(cleanedCode[cleanedCode.index(cleanedCode.startIndex, offsetBy: 4)..<cleanedCode.index(cleanedCode.startIndex, offsetBy: 9)]) // Free Field Block 1
        barcode += String(cleanedCode[cleanedCode.index(cleanedCode.startIndex, offsetBy: 10)..<cleanedCode.index(cleanedCode.startIndex, offsetBy: 20)]) // Free Field Block 2
        barcode += String(cleanedCode[cleanedCode.index(cleanedCode.startIndex, offsetBy: 21)..<cleanedCode.index(cleanedCode.startIndex, offsetBy: 31)]) // Free Field Block 3
        return barcode
    }

}

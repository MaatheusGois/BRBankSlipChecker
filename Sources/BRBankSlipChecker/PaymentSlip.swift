//
//  BoletoArrecadacao.swift
//  BRBankSlipChecker
//
//  Created by Matheus Gois on 28/05/24.
//

import Foundation

/// Pagamento Arrecadação
public enum PaymentSlip {

    public static func validate(_ code: String, validateBlocks: Bool = false) -> Bool {
        let cleanedCode = Utils.clearMask(code)
        switch cleanedCode.count {
            case 44: return paymentSlipBarcode(cleanedCode)
            case 48: return paymentSlipDigitableLine(code, validateBlocks: validateBlocks)
            default: return false
        }
    }

    public static func paymentSlipDigitableLine(_ code: String, validateBlocks: Bool = false) -> Bool {
        let cleanedCode = Utils.clearMask(code)
        guard 
            cleanedCode.count == 48,
            let firstDigit = Int(String(cleanedCode.first ?? "0")),
            firstDigit == 8
        else {
            return false
        }
        let validDV = paymentSlipBarcode(Converter.convertToPaymentSlipBarcode(cleanedCode))
        if !validateBlocks { return validDV }
        let currencyCode = Int(String(cleanedCode[cleanedCode.index(cleanedCode.startIndex, offsetBy: 2)])) ?? 0
        let module: (String) -> Int

        if [6, 7].contains(currencyCode) {
            module = Module.module10
        } else if [8, 9].contains(currencyCode) {
            module = Module.module11Slip
        } else {
            return false
        }

        let blocks = (0..<4).map { index -> (num: String, DV: String) in
            let start = (11 * index) + index
            let end = (11 * (index + 1)) + index
            let num = String(cleanedCode[cleanedCode.index(cleanedCode.startIndex, offsetBy: start)..<cleanedCode.index(cleanedCode.startIndex, offsetBy: end)])
            let DV = String(cleanedCode[cleanedCode.index(cleanedCode.startIndex, offsetBy: end)])
            return (num: num, DV: DV)
        }
        let validBlocks = blocks.allSatisfy { module($0.num) == Int($0.DV) }
        return validBlocks && validDV
    }

    public static func paymentSlipBarcode(_ code: String) -> Bool {
        let cleanedCode = Utils.clearMask(code)
        guard
            cleanedCode.count == 44,
            let firstDigit = Int(String(cleanedCode.first ?? "0")),
            firstDigit == 8
        else {
            return false
        }

        let currencyCode = Int(String(cleanedCode[cleanedCode.index(cleanedCode.startIndex, offsetBy: 2)])) ?? 0
        let DV = Int(String(cleanedCode[cleanedCode.index(cleanedCode.startIndex, offsetBy: 3)])) ?? 0
        let block = cleanedCode.prefix(3) + cleanedCode.suffix(from: cleanedCode.index(cleanedCode.startIndex, offsetBy: 4))

        if [6, 7].contains(currencyCode) {
            return Module.module10(.init(block)) == DV
        } else if [8, 9].contains(currencyCode) {
            return Module.module11Slip(.init(block)) == DV
        } else {
            return false
        }
    }
}

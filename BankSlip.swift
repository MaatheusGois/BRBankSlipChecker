//
//  BankSlip.swift
//  BRBankSlipChecker
//
//  Created by Matheus Gois on 28/05/24.
//

import Foundation

/// Boleto Bancario
public enum BankSlip {

    public static func validate(_ code: String, validateBlocks: Bool = false) -> Bool {
        let cleanedCode = Utils.clearMask(code)
        switch cleanedCode.count {
            case 44: return bankSlipBarcode(cleanedCode)
            case 47: return bankSlipDigitableLine(code, validateBlocks: validateBlocks)
            default: return false
        }
    }

    public static func bankSlipBarcode(_ code: String) -> Bool {
        let cleanedCode = Utils.clearMask(code)
        guard
            cleanedCode.count == 44,
            let DV = Int(String(cleanedCode[cleanedCode.index(cleanedCode.startIndex, offsetBy: 4)]))
        else {
            return false
        }
        let block = cleanedCode.prefix(4) + cleanedCode.suffix(from: cleanedCode.index(cleanedCode.startIndex, offsetBy: 5))
        return Module.bankModule11(String(block)) == DV
    }

    public static func bankSlipDigitableLine(_ code: String, validateBlocks: Bool = false) -> Bool {
        let cleanedCode = Utils.clearMask(code)
        guard cleanedCode.count == 47 else { return false }

        let block1Num = String(cleanedCode.prefix(9))
        let block1DV = String(cleanedCode[cleanedCode.index(cleanedCode.startIndex, offsetBy: 9)])

        let block2Num = String(cleanedCode[cleanedCode.index(cleanedCode.startIndex, offsetBy: 10)..<cleanedCode.index(cleanedCode.startIndex, offsetBy: 20)])
        let block2DV = String(cleanedCode[cleanedCode.index(cleanedCode.startIndex, offsetBy: 20)])

        let block3Num = String(cleanedCode[cleanedCode.index(cleanedCode.startIndex, offsetBy: 21)..<cleanedCode.index(cleanedCode.startIndex, offsetBy: 31)])
        let block3DV = String(cleanedCode[cleanedCode.index(cleanedCode.startIndex, offsetBy: 31)])

        let blocks = [
            (num: block1Num, DV: block1DV),
            (num: block2Num, DV: block2DV),
            (num: block3Num, DV: block3DV)
        ]

        let validBlocks = validateBlocks ? blocks.allSatisfy { Module.module10($0.num) == Int($0.DV) } : true
        let validDV = bankSlipBarcode(Converter.convertToBankSlipBarcode(cleanedCode))
        return validBlocks && validDV
    }
}

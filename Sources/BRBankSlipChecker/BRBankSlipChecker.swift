
//
//  BRBankSlipChecker.swift
//  BRBankSlipChecker
//
//  Created by Matheus Gois on 28/05/24.
//

import Foundation

public enum BRBankSlipChecker {
    public static func validate(_ code: String, validateBlocks: Bool = false) -> Bool {
        let cleanedCode = Utils.clearMask(code)
        if let firstDigit = Int(String(cleanedCode.first ?? "0")), firstDigit == 8 {
            return PaymentSlip.validate(cleanedCode)
        } else {
            return BankSlip.validate(cleanedCode, validateBlocks: validateBlocks)
        }
    }
}

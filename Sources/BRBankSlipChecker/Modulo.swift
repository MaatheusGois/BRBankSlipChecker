//
//  Module.swift
//  BRBankSlipChecker
//
//  Created by Matheus Gois on 28/05/24.
//

import Foundation

enum Module {
    /*
        The numeric representation of the barcode is composed of five fields, with the first
        three being bound by check digits (DVs) and calculated using module 10, as follows:
        a) Module 10 should be used to calculate the check digit (DV) of the first three fields
        of the readable line;
        b) The multipliers start with the number 2, always from the right, alternating between
        1 and 2;
        c) Multiply each digit of the number by its respective weight (multiplier):
        d) If the result of the multiplication is greater than 9, the digits of the product should be summed
        until it is reduced to a single digit:
            a. Example: Result is 18, so 1+8 = 9
        e) Subtract the total obtained in the previous step from the next higher multiple of ten:
            a. Example: Sum result is 25, so 30 - 25
        f) The result obtained will be the check digit of the number;
            a. Example: 30-25 = 5, so 5 is the check digit
        g) If the result of the subtraction is equal to 10, the check digit will be 0 (zero)
    */
    static func module10(_ bloco: String) -> Int {
        let reversedDigits = bloco.reversed().map { Int(String($0)) ?? 0 }
        let somatorio = reversedDigits.enumerated().reduce(0) { (acc, enumeratedElement) in
            let (index, element) = enumeratedElement
            var soma = element * (((index + 1) % 2) + 1)
            soma = (soma > 9) ? (soma / 10) + (soma % 10) : soma
            return acc + soma
        }
        return (Int(ceil(Double(somatorio) / 10.0)) * 10) - somatorio
    }


    /*
        According to BACEN's definition, the 5th position of the barcode must indicate
        the check digit (DV) of the barcode, calculated using module 11, as follows:
        a) The barcode has 44 positions, including the check digit;
        b) To calculate the check digit, consider the first 43 positions of the barcode, from positions 1
        to 4 and from positions 6 to 44;
        c) Multiply each digit of the number by its respective multiplier (weight), starting from the 44th
        position and skipping the 5th position;
        d) The multipliers (weights) vary from 2 to 9;
        e) The first digit from right to left should be multiplied by 2, the second by 3, and so on;
        f) The results of the multiplications should be summed:
            a. Example: (6 x 2) + (3 x 1) + (4 x 8) + ... + (4 x 0) = 712;
        g) The total sum should be divided by 11:
            a. Example: 712/11 = 64. Remainder is 8;
        h) The remainder of the division should be subtracted from 11:
            a. Example: 11 - 8 = 3, therefore "3" is the check digit
        i) If the result of the subtraction is:
            I - equal to 0 .................. check digit is 1
            II - equal to 10 ................. check digit is 1
            III - equal to 11 ................. check digit is 1
            IV - different from 10 and 11 ... check digit will be the result itself, in the example "3"
    */
    static func bankModule11(_ bloco: String) -> Int {
        let reversedDigits = bloco.reversed().map { Int(String($0)) ?? 0 }
        var multiplicador = 2
        let somatorio = reversedDigits.reduce(0) { (acc, element) in
            let soma = element * multiplicador
            multiplicador = (multiplicador == 9) ? 2 : multiplicador + 1
            return acc + soma
        }
        let restoDivisao = somatorio % 11
        let DV = 11 - restoDivisao
        if DV == 0 || DV == 10 || DV == 11 {
            return 1
        }
        return DV
    }


    /*
        The DAC (Auto-Conference Digit) module 11 of a number is calculated by multiplying
        each digit by the sequence of multipliers 2, 3, 4, 5, 6, 7, 8, 9, 2, 3, 4....
        positioned from right to left.

        The sum of the products of this multiplication is divided by 11, obtaining the remainder, which
        must be subtracted from 11, and the result of the subtraction is the DAC.

        Note: When the remainder of the division is 0 or 1, the check digit will be "0",
        and when it is 10, the check digit will be "1".
    */
    static func module11Slip(_ bloco: String) -> Int {
        let reversedDigits = bloco.reversed().map { Int(String($0)) ?? 0 }
        var multiplicador = 2
        let somatorio = reversedDigits.reduce(0) { (acc, element) in
            let soma = element * multiplicador
            multiplicador = (multiplicador == 9) ? 2 : multiplicador + 1
            return acc + soma
        }
        let restoDivisao = somatorio % 11

        if restoDivisao == 0 || restoDivisao == 1 {
            return 0
        }
        if restoDivisao == 10 {
            return 1
        }
        let DV = 11 - restoDivisao
        return DV
    }
}

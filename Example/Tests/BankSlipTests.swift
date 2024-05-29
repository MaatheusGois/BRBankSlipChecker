//
//  BRBankSlipCheckerExampleTests.swift
//  BRBankSlipCheckerExampleTests
//
//  Created by Matheus Gois on 28/05/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import XCTest
@testable import BRBankSlipChecker

final class BankSlipTests: XCTestCase {

    func testValidatingBankSlipDigitableLineWithMask() throws {
        // Given
        let digitableLine = "23793.38128 60007.827136 95000.063305 9 75520000370000"

        // When
        let result = BankSlip.bankSlipDigitableLine(digitableLine)

        // Then
        XCTAssertTrue(result)
    }

    func testValidatingBankSlipDigitableLineWithoutMask() throws {
        // Given
        let digitableLine = "23793381286000782713695000063305975520000370000"

        // When
        let result = BankSlip.bankSlipDigitableLine(digitableLine)

        // Then
        XCTAssertTrue(result)
    }

    func testValidatingBankSlipDigitableLineWithValidBlocks() throws {
        // Given
        let digitableLine = "23793381286000782713695000063305975520000370000"

        // When
        let result = BankSlip.bankSlipDigitableLine(digitableLine, validateBlocks: true)

        // Then
        XCTAssertTrue(result)
    }

    func testInvalidBankSlipDigitableLineValidation() throws {
        // Given
        let digitableLine = "23793.38128 60007.827136 95000.063305 4 75520000370000"

        // When
        let result = BankSlip.bankSlipDigitableLine(digitableLine)

        // Then
        XCTAssertFalse(result)
    }

    func testInvalidSizeBankSlipDigitableLineValidation() throws {
        // Given
        let digitableLine = "23793.38128 6007.827136 95000.063305 4 75520000370000"

        // When
        let result = BankSlip.bankSlipDigitableLine(digitableLine)

        // Then
        XCTAssertFalse(result)
    }

    func testValidatingBankSlipBarcode() throws {
        // Given
        let barcode = "00193373700000001000500940144816060680935031"

        // When
        let result = BankSlip.bankSlipBarcode(barcode)

        // Then
        XCTAssertTrue(result)
    }

    func testInvalidBankSlipBarcodeValidation() throws {
        // Given
        let barcode = "00153373700000001000500940144816060680935031"

        // When
        let result = BankSlip.bankSlipBarcode(barcode)

        // Then
        XCTAssertFalse(result)
    }

    func testInvalidSizeBankSlipBarcodeValidation() throws {
        // Given
        let barcode = "0015337300000001000500940144816060680935031"

        // When
        let result = BankSlip.bankSlipBarcode(barcode)

        // Then
        XCTAssertFalse(result)
    }

    func testBankSlipValidation() throws {
        // Given
        let bankSlip = "23793381286000782713695000063305975520000370000"

        // When
        let result = BankSlip.validate(bankSlip)

        // Then
        XCTAssertTrue(result)
    }

    func testBankSlipValidationWithValidBlocks() throws {
        // Given
        let bankSlip = "23793381286000782713695000063305975520000370000"

        // When
        let result = BankSlip.validate(bankSlip, validateBlocks: true)

        // Then
        XCTAssertTrue(result)
    }

    func testInvalidBankSlipValidation() throws {
        // Given
        let bankSlip = "2379338128600078271369500006975520000370000"

        // When
        let result = BankSlip.validate(bankSlip)

        // Then
        XCTAssertFalse(result)
    }

}

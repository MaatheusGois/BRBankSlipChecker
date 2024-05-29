//
//  BRBankSlipCheckerTests.swift
//  BRBankSlipCheckerTests
//
//  Created by Matheus Gois on 28/05/24.
//

import XCTest
@testable import BRBankSlipChecker

final class BRBankSlipCheckerTests: XCTestCase {


    func testBankSlipDigitableLineValidation() throws {
        // Given
        let digitableLine = "23793.38128 60007.827136 95000.063305 9 75520000370000"

        // When
        let result = BRBankSlipChecker.validate(digitableLine)

        // Then
        XCTAssertTrue(result)
    }

    func testBankSlipDigitableLineValidationWithValidBlocks() throws {
        // Given
        let digitableLine = "23793.38128 60007.827136 95000.063305 9 75520000370000"

        // When
        let result = BRBankSlipChecker.validate(digitableLine, validateBlocks: true)

        // Then
        XCTAssertTrue(result)
    }

    func testBankSlipBarcodeValidation() throws {
        // Given
        let barcode = "00193373700000001000500940144816060680935031"

        // When
        let result = BRBankSlipChecker.validate(barcode)

        // Then
        XCTAssertTrue(result)
    }

    func testCollectionBillDigitableLineValidation() throws {
        // Given
        let digitableLine = "85890000460-9 52460179160-5 60759305086-5 83148300001-0"

        // When
        let result = BRBankSlipChecker.validate(digitableLine)

        // Then
        XCTAssertTrue(result)
    }

    func testCollectionBillBarcodeValidation() throws {
        // Given
        let barcode = "83620000000667800481001809756573100158963608"

        // When
        let result = BRBankSlipChecker.validate(barcode)

        // Then
        XCTAssertTrue(result)
    }

    func testUnidentifiedBankSlipFormat() throws {
        // Given
        let unidentifiedFormat = "836200000000481001809756573100158963608"

        // When
        let result = BRBankSlipChecker.validate(unidentifiedFormat)

        // Then
        XCTAssertFalse(result)
    }
}

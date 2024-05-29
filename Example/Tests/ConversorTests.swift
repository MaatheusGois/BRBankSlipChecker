//
//  ConversorTests.swift
//  BRBankSlipCheckerTests
//
//  Created by Matheus Gois on 28/05/24.
//

import XCTest
@testable import BRBankSlipChecker

final class ConversorTests: XCTestCase {

    func testBankSlipDigitableLineToBarcodeConversion() throws {
        // Given
        let digitableLine = "23793381286000782713695000063305975520000370000"

        // When
        let result = Converter.convertToBankSlipBarcode(digitableLine)

        // Then
        XCTAssertEqual(result, "23799755200003700003381260007827139500006330")
    }

    func testCollectionBillDigitableLineToBarcodeConversion() throws {
        // Given
        let digitableLine = "836200000005 667800481000 180975657313 001589636081"

        // When
        let result = Converter.convertToPaymentSlipBarcode(digitableLine)

        // Then
        XCTAssertEqual(result, "83620000000667800481001809756573100158963608")
    }

}

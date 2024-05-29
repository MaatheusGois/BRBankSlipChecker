//
//  PaymentSlipTests.swift
//  BRBankSlipCheckerTests
//
//  Created by Matheus Gois on 28/05/2024.
//

import XCTest
@testable import BRBankSlipChecker

final class PaymentSlipTests: XCTestCase {

    func testDigitableLineValidationModulo10WithMask() throws {
        // Given
        let digitableLine = "836200000005 667800481000 180975657313 001589636081"

        // When
        let result = PaymentSlip.paymentSlipDigitableLine(digitableLine)

        // Then
        XCTAssertTrue(result)
    }

    func testDigitableLineValidationModulo10WithoutMask() throws {
        // Given
        let digitableLine = "836200000005667800481000180975657313001589636081"

        // When
        let result = PaymentSlip.paymentSlipDigitableLine(digitableLine)

        // Then
        XCTAssertTrue(result)
    }

    func testDigitableLineValidationWithValidModulo10Blocks() throws {
        // Given
        let digitableLine = "836200000005667800481000180975657313001589636081"

        // When
        let result = PaymentSlip.paymentSlipDigitableLine(digitableLine, validateBlocks: true)

        // Then
        XCTAssertTrue(result)
    }

    func testInvalidDigitableLineValidationModulo10() throws {
        // Given
        let digitableLine = "836200000005667800481800180975657313001589636081"

        // When
        let result = PaymentSlip.paymentSlipDigitableLine(digitableLine)

        // Then
        XCTAssertFalse(result)
    }

    func testDigitableLineValidationModulo11WithMask() throws {
        // Given
        let digitableLine = "85890000460-9 52460179160-5 60759305086-5 83148300001-0"

        // When
        let result = PaymentSlip.paymentSlipDigitableLine(digitableLine)

        // Then
        XCTAssertTrue(result)
    }

    func testDigitableLineValidationModulo11WithoutMask() throws {
        // Given
        let digitableLine = "848900000002404201622015806051904292586034111220"

        // When
        let result = PaymentSlip.paymentSlipDigitableLine(digitableLine)

        // Then
        XCTAssertTrue(result)
    }

    func testInvalidDigitableLineValidationModulo11() throws {
        // Given
        let digitableLine = "848900000002404201622015809051904292586034111220"

        // When
        let result = PaymentSlip.paymentSlipDigitableLine(digitableLine)

        // Then
        XCTAssertFalse(result)
    }

    func testDigitableLineValidationWithInvalidIdentification() throws {
        // Given
        let digitableLine = "536400000011331201380002812884627116080136181551"

        // When
        let result = PaymentSlip.paymentSlipDigitableLine(digitableLine)

        // Then
        XCTAssertFalse(result)
    }

    func testDigitableLineValidationWithInvalidCurrency() throws {
        // Given
        let digitableLine = "842900000002404201622015806051904292586034111220"

        // When
        let result = PaymentSlip.paymentSlipDigitableLine(digitableLine, validateBlocks: true)

        // Then
        XCTAssertFalse(result)
    }

    func testDigitableLineValidationWithInvalidSize() throws {
        // Given
        let digitableLine = "53640000001133120180002812884627116080136181551"

        // When
        let result = PaymentSlip.paymentSlipDigitableLine(digitableLine)

        // Then
        XCTAssertFalse(result)
    }

    func testBarcodeValidationModulo10() throws {
        // Given
        let barcode = "83620000000667800481001809756573100158963608"

        // When
        let result = PaymentSlip.paymentSlipBarcode(barcode)

        // Then
        XCTAssertTrue(result)
    }

    func testBarcodeValidationModulo11() throws {
        // Given
        let barcode = "84890000000404201622018060519042958603411122"

        // When
        let result = PaymentSlip.paymentSlipBarcode(barcode)

        // Then
        XCTAssertTrue(result)
    }

    func testInvalidBarcodeValidation() throws {
        // Given
        let barcode = "83620000000667800481001809756573800158963608"

        // When
        let result = PaymentSlip.paymentSlipBarcode(barcode)

        // Then
        XCTAssertFalse(result)
    }

    func testBarcodeValidationWithInvalidIdentification() throws {
        // Given
        let barcode = "54640000000873500240300150349033470804040612"

        // When
        let result = PaymentSlip.paymentSlipBarcode(barcode)

        // Then
        XCTAssertFalse(result)
    }

    func testBarcodeValidationWithInvalidCurrency() throws {
        // Given
        let barcode = "84240000000873500240300150349033470804040612"

        // When
        let result = PaymentSlip.paymentSlipBarcode(barcode)

        // Then
        XCTAssertFalse(result)
    }

    func testBarcodeValidationWithInvalidSize() throws {
        // Given
        let barcode = "8464000000087350024030015034903370804040612"

        // When
        let result = PaymentSlip.paymentSlipBarcode(barcode)

        // Then
        XCTAssertFalse(result)
    }

    func testCollectionBillValidation() throws {
        // Given
        let bill = "836200000005667800481000180975657313001589636081"

        // When
        let result = PaymentSlip.validate(bill)

        // Then
        XCTAssertTrue(result)
    }

    func testCollectionBillValidationWithValidBlocks() throws {
        // Given
        let bill = "836200000005667800481000180975657313001589636081"

        // When
        let result = PaymentSlip.validate(bill, validateBlocks: true)

        // Then
        XCTAssertTrue(result)
    }

    func testInvalidCollectionBillValidation() throws {
        // Given
        let bill = "836200000007800481000180975657313001589636081"

        // When
        let result = PaymentSlip.validate(bill)

        // Then
        XCTAssertFalse(result)
    }

    func testCollectionBillValidationWithSpecificModulo11() throws {
        // Given
        let bill = "858000000070438403281922630720192528304729600523"

        // When
        let result = PaymentSlip.validate(bill)

        // Then
        XCTAssertTrue(result)
    }

}

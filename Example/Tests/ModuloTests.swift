//
//  ModuleTests.swift
//  BRBankSlipCheckerTests
//
//  Created by Matheus Gois on 28/05/24.
//

import XCTest
@testable import BRBankSlipChecker

final class ModuleTests: XCTestCase {

    // MARK: - module10 Tests

    func testModule10Valid() throws {
        // Given
        let bloco = "00190.00009 05414.481606 90680.935031 4 33730000000100"

        // When
        let result = Module.module10(bloco)

        // Then
        XCTAssertEqual(result, 4)
    }

    func testModule10Invalid() throws {
        // Given
        let bloco = "00190.00009 05414.481606 90680.935031 4 33730000000101"

        // When
        let result = Module.module10(bloco)

        // Then
        XCTAssertEqual(result, 2)
    }

    // MARK: - bankModule11 Tests

    func testBankModule11Valid() throws {
        // Given
        let bloco = "00190.00009 05414.481606 90680.935031 4 33730000000100"

        // When
        let result = Module.bankModule11(bloco)

        // Then
        XCTAssertEqual(result, 1)
    }

    func testBankModule11Invalid() throws {
        // Given
        let bloco = "00190.00009 05414.481606 90680.935031 4 33730000000101"

        // When
        let result = Module.bankModule11(bloco)

        // Then
        XCTAssertEqual(result, 9)
    }

    // MARK: - module11Slip Tests

    func testModule11SlipValid() throws {
        // Given
        let bloco = "00190.00009 05414.481606 90680.935031 4 33730000000100"

        // When
        let result = Module.module11Slip(bloco)

        // Then
        XCTAssertEqual(result, 0)
    }

    func testModule11SlipInvalid() throws {
        // Given
        let bloco = "00190.00009 05414.481606 90680.935031 4 33730000000101"

        // When
        let result = Module.module11Slip(bloco)

        // Then
        XCTAssertEqual(result, 9)
    }
}

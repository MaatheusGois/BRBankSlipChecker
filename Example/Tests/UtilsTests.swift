//
//  UtilsTests.swift
//  BRBankSlipCheckerTests
//
//  Created by Matheus Gois on 28/05/2024.
//

import XCTest
@testable import BRBankSlipChecker

final class UtilsTests: XCTestCase {

    // MARK: - clearMask Tests

    func testClearMaskWithSpaces() throws {
        // Given
        let codigo = "12 34 56"

        // When
        let result = Utils.clearMask(codigo)

        // Then
        XCTAssertEqual(result, "123456")
    }

    func testClearMaskWithDots() throws {
        // Given
        let codigo = "12.34.56"

        // When
        let result = Utils.clearMask(codigo)

        // Then
        XCTAssertEqual(result, "123456")
    }

    func testClearMaskWithDashes() throws {
        // Given
        let codigo = "12-34-56"

        // When
        let result = Utils.clearMask(codigo)

        // Then
        XCTAssertEqual(result, "123456")
    }

    func testClearMaskWithMixedCharacters() throws {
        // Given
        let codigo = "12.3-4 5"

        // When
        let result = Utils.clearMask(codigo)

        // Then
        XCTAssertEqual(result, "12345")
    }

    func testClearMaskWithoutMask() throws {
        // Given
        let codigo = "123456"

        // When
        let result = Utils.clearMask(codigo)

        // Then
        XCTAssertEqual(result, "123456")
    }
}

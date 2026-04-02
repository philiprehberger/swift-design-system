import XCTest
@testable import DesignSystem

final class TokenValidatorTests: XCTestCase {
    func testValidTheme() {
        let theme = Theme(
            name: "valid",
            colors: ["primary": ColorToken(hex: "#0066FF")!],
            spacing: ["sm": SpacingToken(8)],
            typography: ["body": TypographyToken(fontSize: 16)]
        )
        let issues = TokenValidator.validate(
            theme,
            requiredColors: ["primary"],
            requiredSpacing: ["sm"],
            requiredTypography: ["body"]
        )
        let errors = issues.filter { $0.severity == .error }
        XCTAssertTrue(errors.isEmpty)
    }

    func testMissingRequiredColor() {
        let theme = Theme(name: "incomplete", colors: [:])
        let issues = TokenValidator.validate(theme, requiredColors: ["primary", "background"])
        let errors = issues.filter { $0.severity == .error }
        XCTAssertEqual(errors.count, 2)
    }

    func testEmptyThemeWarnings() {
        let theme = Theme(name: "empty")
        let issues = TokenValidator.validate(theme)
        let warnings = issues.filter { $0.severity == .warning }
        XCTAssertEqual(warnings.count, 3) // no colors, no spacing, no typography
    }

    func testMixedIssues() {
        let theme = Theme(
            name: "partial",
            colors: ["primary": ColorToken(hex: "#FF0000")!]
        )
        let issues = TokenValidator.validate(
            theme,
            requiredColors: ["primary", "secondary"]
        )
        let errors = issues.filter { $0.severity == .error }
        let warnings = issues.filter { $0.severity == .warning }
        XCTAssertEqual(errors.count, 1) // missing secondary
        XCTAssertTrue(warnings.count >= 2) // no spacing, no typography
    }
}

import XCTest
@testable import DesignSystem

final class DesignTokenTests: XCTestCase {
    func testColorFromHex() {
        guard let color = ColorToken(hex: "#FF5733") else {
            XCTFail("Failed to parse hex color")
            return
        }
        XCTAssertEqual(color.red, 1.0, accuracy: 0.01)
        XCTAssertEqual(color.green, 0.341, accuracy: 0.01)
        XCTAssertEqual(color.blue, 0.2, accuracy: 0.01)
    }

    func testColorToHex() {
        let color = ColorToken(red: 1.0, green: 0.0, blue: 0.0)
        XCTAssertEqual(color.hex, "#FF0000")
    }

    func testColorHexWithoutHash() {
        let color = ColorToken(hex: "00FF00")
        XCTAssertNotNil(color)
        XCTAssertEqual(color?.hex, "#00FF00")
    }

    func testInvalidHex() {
        XCTAssertNil(ColorToken(hex: "xyz"))
        XCTAssertNil(ColorToken(hex: "#12"))
    }

    func testSpacingToken() {
        let spacing = SpacingToken(16.0)
        XCTAssertEqual(spacing.value, 16.0)
    }

    func testTypographyToken() {
        let typo = TypographyToken(fontSize: 18, fontWeight: .bold, lineHeight: 24)
        XCTAssertEqual(typo.fontSize, 18)
        XCTAssertEqual(typo.fontWeight, .bold)
        XCTAssertEqual(typo.lineHeight, 24)
    }

    func testFontWeightCases() {
        XCTAssertEqual(FontWeight.allCases.count, 9)
    }

    func testShadowToken() {
        let shadow = ShadowToken(
            color: ColorToken(red: 0, green: 0, blue: 0),
            radius: 10,
            xOffset: 2,
            yOffset: 4,
            opacity: 0.5
        )
        XCTAssertEqual(shadow.radius, 10)
        XCTAssertEqual(shadow.xOffset, 2)
        XCTAssertEqual(shadow.yOffset, 4)
        XCTAssertEqual(shadow.opacity, 0.5)
    }

    func testBorderToken() {
        let border = BorderToken(
            width: 2,
            color: ColorToken(hex: "#000000")!,
            style: .dashed
        )
        XCTAssertEqual(border.width, 2)
        XCTAssertEqual(border.style, .dashed)
    }

    func testBorderStyleCases() {
        XCTAssertEqual(BorderStyle.allCases.count, 3)
    }
}

import XCTest
@testable import DesignSystem

final class ThemeTests: XCTestCase {
    func testThemeLookup() {
        let theme = Theme(
            name: "light",
            colors: ["primary": ColorToken(hex: "#0066FF")!],
            spacing: ["sm": SpacingToken(8)],
            typography: ["body": TypographyToken(fontSize: 16)]
        )
        XCTAssertEqual(theme.color("primary")?.hex, "#0066FF")
        XCTAssertEqual(theme.spacing("sm")?.value, 8)
        XCTAssertEqual(theme.typography("body")?.fontSize, 16)
    }

    func testThemeMissing() {
        let theme = Theme(name: "empty")
        XCTAssertNil(theme.color("missing"))
        XCTAssertNil(theme.spacing("missing"))
    }

    func testMergeThemes() {
        let base = Theme(name: "base", colors: ["bg": ColorToken(hex: "#FFFFFF")!])
        let dark = Theme(name: "dark", colors: ["bg": ColorToken(hex: "#000000")!])
        let merged = base.merging(dark)
        XCTAssertEqual(merged.name, "dark")
        XCTAssertEqual(merged.color("bg")?.hex, "#000000")
    }

    func testShadowLookup() {
        let theme = Theme(
            name: "test",
            shadows: ["card": ShadowToken(color: ColorToken(red: 0, green: 0, blue: 0), radius: 8)]
        )
        XCTAssertEqual(theme.shadow("card")?.radius, 8)
        XCTAssertNil(theme.shadow("missing"))
    }

    func testBorderLookup() {
        let theme = Theme(
            name: "test",
            borders: ["input": BorderToken(width: 1, color: ColorToken(hex: "#CCCCCC")!)]
        )
        XCTAssertEqual(theme.border("input")?.width, 1)
    }

    func testExtending() {
        let base = Theme(
            name: "base",
            colors: ["bg": ColorToken(hex: "#FFFFFF")!, "text": ColorToken(hex: "#000000")!]
        )
        let dark = Theme(
            name: "dark",
            colors: ["bg": ColorToken(hex: "#111111")!]
        )
        let result = base.extending(dark)
        XCTAssertEqual(result.name, "dark")
        XCTAssertEqual(result.color("bg")?.hex, "#111111")
        XCTAssertEqual(result.color("text")?.hex, "#000000") // inherited
    }
}

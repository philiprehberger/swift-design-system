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
}

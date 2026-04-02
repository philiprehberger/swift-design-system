import XCTest
@testable import DesignSystem

final class TokenExporterTests: XCTestCase {
    func testExportAndImportRoundTrip() throws {
        let theme = Theme(
            name: "test",
            colors: ["primary": ColorToken(hex: "#FF0000")!],
            spacing: ["md": SpacingToken(16)],
            typography: ["heading": TypographyToken(fontSize: 24, fontWeight: .bold, lineHeight: 32)]
        )

        let json = try TokenExporter.exportJSON(theme)
        let imported = TokenExporter.importJSON(json)

        XCTAssertNotNil(imported)
        XCTAssertEqual(imported?.name, "test")
        XCTAssertEqual(imported?.color("primary")?.hex, "#FF0000")
        XCTAssertEqual(imported?.spacing("md")?.value, 16)
        XCTAssertEqual(imported?.typography("heading")?.fontSize, 24)
        XCTAssertEqual(imported?.typography("heading")?.fontWeight, .bold)
    }

    func testExportDict() {
        let theme = Theme(name: "minimal", colors: ["bg": ColorToken(hex: "#FFFFFF")!])
        let dict = TokenExporter.exportTheme(theme)
        XCTAssertEqual(dict["name"] as? String, "minimal")
        XCTAssertNotNil(dict["colors"])
    }

    func testImportInvalidJSON() {
        let data = "not json".data(using: .utf8)!
        XCTAssertNil(TokenExporter.importJSON(data))
    }

    func testImportMissingName() {
        let dict: [String: Any] = ["colors": [:]]
        XCTAssertNil(TokenExporter.importTheme(from: dict))
    }
}

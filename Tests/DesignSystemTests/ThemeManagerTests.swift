import XCTest
@testable import DesignSystem

final class ThemeManagerTests: XCTestCase {
    func testRegisterAndSwitch() {
        let manager = ThemeManager()
        manager.register(Theme(name: "light"))
        manager.register(Theme(name: "dark"))
        XCTAssertEqual(manager.activeThemeName, "light")
        XCTAssertTrue(manager.switchTo("dark"))
        XCTAssertEqual(manager.activeThemeName, "dark")
    }

    func testSwitchToNonexistent() {
        let manager = ThemeManager()
        manager.register(Theme(name: "light"))
        XCTAssertFalse(manager.switchTo("missing"))
    }

    func testAvailableThemes() {
        let manager = ThemeManager()
        manager.register(Theme(name: "a"))
        manager.register(Theme(name: "b"))
        XCTAssertEqual(manager.availableThemes, ["a", "b"])
    }

    func testOnChange() {
        let manager = ThemeManager()
        manager.register(Theme(name: "light"))
        manager.register(Theme(name: "dark"))
        var notified = false
        manager.onChange { _ in notified = true }
        manager.switchTo("dark")
        XCTAssertTrue(notified)
    }

    func testThemeNamed() {
        let manager = ThemeManager()
        let theme = Theme(name: "custom", colors: ["x": ColorToken(hex: "#FF0000")!])
        manager.register(theme)
        XCTAssertEqual(manager.theme(named: "custom")?.color("x")?.hex, "#FF0000")
    }
}

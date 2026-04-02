import XCTest
@testable import DesignSystem

final class ComponentRegistryTests: XCTestCase {
    func testRegisterAndRetrieve() {
        let registry = ComponentRegistry()
        let style = ComponentStyle(name: "button.primary", properties: ["bg": "#0066FF", "radius": "8"])
        registry.register(style)
        let result = registry.style(named: "button.primary")
        XCTAssertEqual(result?.properties["bg"], "#0066FF")
    }

    func testAllStyles() {
        let registry = ComponentRegistry()
        registry.register(ComponentStyle(name: "a"))
        registry.register(ComponentStyle(name: "b"))
        XCTAssertEqual(registry.allStyles, ["a", "b"])
    }

    func testCount() {
        let registry = ComponentRegistry()
        registry.register(ComponentStyle(name: "x"))
        XCTAssertEqual(registry.count, 1)
    }

    func testRemove() {
        let registry = ComponentRegistry()
        registry.register(ComponentStyle(name: "x"))
        let removed = registry.remove("x")
        XCTAssertNotNil(removed)
        XCTAssertEqual(registry.count, 0)
    }

    func testMissingStyle() {
        let registry = ComponentRegistry()
        XCTAssertNil(registry.style(named: "missing"))
    }
}

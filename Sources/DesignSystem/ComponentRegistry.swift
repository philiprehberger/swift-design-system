import Foundation

/// A named component style configuration.
public struct ComponentStyle: Sendable {
    public let name: String
    public let properties: [String: String]

    public init(name: String, properties: [String: String] = [:]) {
        self.name = name
        self.properties = properties
    }
}

/// Registry of named component styles.
public final class ComponentRegistry: @unchecked Sendable {
    private let lock = NSLock()
    private var styles: [String: ComponentStyle] = [:]

    public init() {}

    /// Register a component style.
    public func register(_ style: ComponentStyle) {
        lock.lock()
        styles[style.name] = style
        lock.unlock()
    }

    /// Retrieve a component style by name.
    public func style(named: String) -> ComponentStyle? {
        lock.lock()
        defer { lock.unlock() }
        return styles[named]
    }

    /// List all registered style names.
    public var allStyles: [String] {
        lock.lock()
        defer { lock.unlock() }
        return styles.keys.sorted()
    }

    /// Number of registered styles.
    public var count: Int {
        lock.lock()
        defer { lock.unlock() }
        return styles.count
    }

    /// Remove a style by name.
    @discardableResult
    public func remove(_ name: String) -> ComponentStyle? {
        lock.lock()
        defer { lock.unlock() }
        return styles.removeValue(forKey: name)
    }
}

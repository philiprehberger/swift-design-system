import Foundation

/// Manages the active theme and notifies observers on change.
public final class ThemeManager: @unchecked Sendable {
    private let lock = NSLock()
    private var themes: [String: Theme] = [:]
    private var _activeThemeName: String = ""
    private var observers: [(Theme) -> Void] = []

    public init() {}

    /// Register a theme.
    public func register(_ theme: Theme) {
        lock.lock()
        themes[theme.name] = theme
        if _activeThemeName.isEmpty {
            _activeThemeName = theme.name
        }
        lock.unlock()
    }

    /// Switch to a named theme.
    ///
    /// - Returns: True if the theme exists and was activated.
    @discardableResult
    public func switchTo(_ name: String) -> Bool {
        lock.lock()
        guard let theme = themes[name] else {
            lock.unlock()
            return false
        }
        _activeThemeName = name
        let currentObservers = observers
        lock.unlock()
        for observer in currentObservers {
            observer(theme)
        }
        return true
    }

    /// The currently active theme.
    public var activeTheme: Theme? {
        lock.lock()
        defer { lock.unlock() }
        return themes[_activeThemeName]
    }

    /// Name of the active theme.
    public var activeThemeName: String {
        lock.lock()
        defer { lock.unlock() }
        return _activeThemeName
    }

    /// List all registered theme names.
    public var availableThemes: [String] {
        lock.lock()
        defer { lock.unlock() }
        return themes.keys.sorted()
    }

    /// Register an observer called when the theme changes.
    public func onChange(_ handler: @escaping (Theme) -> Void) {
        lock.lock()
        observers.append(handler)
        lock.unlock()
    }

    /// Get a theme by name without switching.
    public func theme(named: String) -> Theme? {
        lock.lock()
        defer { lock.unlock() }
        return themes[named]
    }
}

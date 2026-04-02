import Foundation

/// Design system engine managing themes, component styles, and token export.
public final class DesignSystem: @unchecked Sendable {
    /// Shared instance.
    public static let shared = DesignSystem()

    /// Theme manager for switching between themes.
    public let themes = ThemeManager()

    /// Component style registry.
    public let components = ComponentRegistry()

    private init() {}

    /// Convenience: get a color from the active theme.
    public func color(_ name: String) -> ColorToken? {
        themes.activeTheme?.color(name)
    }

    /// Convenience: get spacing from the active theme.
    public func spacing(_ name: String) -> SpacingToken? {
        themes.activeTheme?.spacing(name)
    }

    /// Convenience: get typography from the active theme.
    public func typography(_ name: String) -> TypographyToken? {
        themes.activeTheme?.typography(name)
    }

    /// Export the active theme as JSON data.
    public func exportActiveTheme() throws -> Data {
        guard let theme = themes.activeTheme else {
            throw DesignSystemError.noActiveTheme
        }
        return try TokenExporter.exportJSON(theme)
    }

    /// Import a theme from JSON data and register it.
    @discardableResult
    public func importTheme(from data: Data) -> Theme? {
        guard let theme = TokenExporter.importJSON(data) else { return nil }
        themes.register(theme)
        return theme
    }
}

/// Errors for the design system.
public enum DesignSystemError: Error, Sendable {
    case noActiveTheme
}

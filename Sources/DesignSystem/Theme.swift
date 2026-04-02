import Foundation

/// A design system theme containing color, spacing, and typography tokens.
public struct Theme: Sendable {
    /// Theme name (e.g., "light", "dark", "brand").
    public let name: String

    /// Named color tokens.
    public let colors: [String: ColorToken]

    /// Named spacing tokens.
    public let spacing: [String: SpacingToken]

    /// Named typography tokens.
    public let typography: [String: TypographyToken]

    /// Named shadow tokens.
    public let shadows: [String: ShadowToken]

    /// Named border tokens.
    public let borders: [String: BorderToken]

    public init(
        name: String,
        colors: [String: ColorToken] = [:],
        spacing: [String: SpacingToken] = [:],
        typography: [String: TypographyToken] = [:],
        shadows: [String: ShadowToken] = [:],
        borders: [String: BorderToken] = [:]
    ) {
        self.name = name
        self.colors = colors
        self.spacing = spacing
        self.typography = typography
        self.shadows = shadows
        self.borders = borders
    }

    /// Look up a color token by name.
    public func color(_ name: String) -> ColorToken? {
        colors[name]
    }

    /// Look up a spacing token by name.
    public func spacing(_ name: String) -> SpacingToken? {
        spacing[name]
    }

    /// Look up a typography token by name.
    public func typography(_ name: String) -> TypographyToken? {
        typography[name]
    }

    /// Look up a shadow token by name.
    public func shadow(_ name: String) -> ShadowToken? {
        shadows[name]
    }

    /// Look up a border token by name.
    public func border(_ name: String) -> BorderToken? {
        borders[name]
    }

    /// Create a new theme by merging another theme's tokens (other takes priority).
    public func merging(_ other: Theme) -> Theme {
        Theme(
            name: other.name,
            colors: colors.merging(other.colors) { _, new in new },
            spacing: spacing.merging(other.spacing) { _, new in new },
            typography: typography.merging(other.typography) { _, new in new },
            shadows: shadows.merging(other.shadows) { _, new in new },
            borders: borders.merging(other.borders) { _, new in new }
        )
    }

    /// Create a child theme that inherits all tokens from this theme, with overrides.
    ///
    /// - Parameter overrides: The theme containing override tokens.
    /// - Returns: A new theme with this theme's tokens plus overrides.
    public func extending(_ overrides: Theme) -> Theme {
        merging(overrides)
    }
}

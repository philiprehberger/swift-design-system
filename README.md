# DesignSystem

[![Tests](https://github.com/philiprehberger/swift-design-system/actions/workflows/ci.yml/badge.svg)](https://github.com/philiprehberger/swift-design-system/actions/workflows/ci.yml)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fphiliprehberger%2Fswift-design-system%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/philiprehberger/swift-design-system)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fphiliprehberger%2Fswift-design-system%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/philiprehberger/swift-design-system)

Token-based design system engine with theme switching, component registry, and JSON export

## Requirements

- Swift >= 6.0
- macOS 13+ / iOS 16+ / tvOS 16+ / watchOS 9+

## Installation

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/philiprehberger/swift-design-system.git", from: "0.1.0")
]
```

Then add `"DesignSystem"` to your target dependencies:

```swift
.target(name: "YourTarget", dependencies: [
    .product(name: "DesignSystem", package: "swift-design-system")
])
```

## Usage

```swift
import DesignSystem

let ds = DesignSystem.shared

ds.themes.register(Theme(
    name: "light",
    colors: ["primary": ColorToken(hex: "#0066FF")!],
    spacing: ["md": SpacingToken(16)],
    typography: ["body": TypographyToken(fontSize: 16, fontWeight: .regular)]
))

ds.color("primary")?.hex  // "#0066FF"
```

### Themes

Define and switch between named themes:

```swift
let light = Theme(
    name: "light",
    colors: ["bg": ColorToken(hex: "#FFFFFF")!, "text": ColorToken(hex: "#111111")!],
    spacing: ["sm": SpacingToken(8), "md": SpacingToken(16), "lg": SpacingToken(32)],
    typography: ["heading": TypographyToken(fontSize: 24, fontWeight: .bold, lineHeight: 32)]
)

let dark = Theme(
    name: "dark",
    colors: ["bg": ColorToken(hex: "#111111")!, "text": ColorToken(hex: "#FFFFFF")!],
    spacing: light.spacing,
    typography: light.typography
)

ds.themes.register(light)
ds.themes.register(dark)
ds.themes.switchTo("dark")
ds.color("bg")?.hex  // "#111111"
```

### Theme Observers

React to theme changes:

```swift
ds.themes.onChange { theme in
    print("Switched to \(theme.name)")
}
```

### Component Registry

Register reusable component style configurations:

```swift
ds.components.register(ComponentStyle(
    name: "button.primary",
    properties: ["backgroundColor": "#0066FF", "cornerRadius": "8", "textColor": "#FFFFFF"]
))

let style = ds.components.style(named: "button.primary")
style?.properties["backgroundColor"]  // "#0066FF"
```

### Design Tokens

```swift
// Colors with hex parsing
let color = ColorToken(hex: "#FF5733")!
color.red    // 1.0
color.hex    // "#FF5733"

// Spacing
let spacing = SpacingToken(16)

// Typography
let heading = TypographyToken(fontSize: 24, fontWeight: .bold, lineHeight: 32, letterSpacing: -0.5)
```

### JSON Export / Import (Figma Bridge)

Export tokens for handoff to designers, or import from Figma:

```swift
// Export
let json = try ds.exportActiveTheme()
let jsonString = String(data: json, encoding: .utf8)!

// Import
let imported = ds.importTheme(from: jsonData)
ds.themes.switchTo(imported!.name)
```

### Theme Merging

Extend a base theme with overrides:

```swift
let brand = base.merging(Theme(
    name: "brand",
    colors: ["primary": ColorToken(hex: "#FF6600")!]
))
// Inherits all base tokens, overrides "primary"
```

## API

### `DesignSystem`

| Method | Description |
|--------|-------------|
| `.shared` | Singleton instance |
| `.themes` | Access the ThemeManager |
| `.components` | Access the ComponentRegistry |
| `.color(_:)` | Get color from active theme |
| `.spacing(_:)` | Get spacing from active theme |
| `.typography(_:)` | Get typography from active theme |
| `.exportActiveTheme()` | Export active theme as JSON |
| `.importTheme(from:)` | Import theme from JSON data |

### `Theme`

| Method | Description |
|--------|-------------|
| `.color(_:)` | Look up a named color token |
| `.spacing(_:)` | Look up a named spacing token |
| `.typography(_:)` | Look up a named typography token |
| `.merging(_:)` | Merge with another theme |

### `ThemeManager`

| Method | Description |
|--------|-------------|
| `.register(_:)` | Register a theme |
| `.switchTo(_:)` | Switch active theme |
| `.activeTheme` | Current theme |
| `.availableThemes` | List theme names |
| `.onChange(_:)` | Observe theme changes |

### `ComponentRegistry`

| Method | Description |
|--------|-------------|
| `.register(_:)` | Register a component style |
| `.style(named:)` | Retrieve by name |
| `.allStyles` | List style names |
| `.remove(_:)` | Remove a style |

### `TokenExporter`

| Method | Description |
|--------|-------------|
| `.exportJSON(_:)` | Export theme to JSON data |
| `.importJSON(_:)` | Import theme from JSON data |
| `.exportTheme(_:)` | Export to dictionary |
| `.importTheme(from:)` | Import from dictionary |

## Development

```bash
swift build
swift test
```

## Support

If you find this project useful:

⭐ [Star the repo](https://github.com/philiprehberger/swift-design-system)

🐛 [Report issues](https://github.com/philiprehberger/swift-design-system/issues?q=is%3Aissue+is%3Aopen+label%3Abug)

💡 [Suggest features](https://github.com/philiprehberger/swift-design-system/issues?q=is%3Aissue+is%3Aopen+label%3Aenhancement)

❤️ [Sponsor development](https://github.com/sponsors/philiprehberger)

🌐 [All Open Source Projects](https://philiprehberger.com/open-source-packages)

💻 [GitHub Profile](https://github.com/philiprehberger)

🔗 [LinkedIn Profile](https://www.linkedin.com/in/philiprehberger)

## License

[MIT](LICENSE)

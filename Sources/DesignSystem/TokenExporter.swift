import Foundation

/// Export and import design tokens as JSON.
public enum TokenExporter {
    /// Export a theme to a JSON-compatible dictionary.
    public static func exportTheme(_ theme: Theme) -> [String: Any] {
        var result: [String: Any] = ["name": theme.name]

        var colorMap: [String: Any] = [:]
        for (name, token) in theme.colors {
            colorMap[name] = ["hex": token.hex, "r": token.red, "g": token.green, "b": token.blue, "a": token.alpha]
        }
        result["colors"] = colorMap

        var spacingMap: [String: Any] = [:]
        for (name, token) in theme.spacing {
            spacingMap[name] = token.value
        }
        result["spacing"] = spacingMap

        var typoMap: [String: Any] = [:]
        for (name, token) in theme.typography {
            var entry: [String: Any] = ["fontSize": token.fontSize, "fontWeight": token.fontWeight.rawValue]
            if let lh = token.lineHeight { entry["lineHeight"] = lh }
            if let ls = token.letterSpacing { entry["letterSpacing"] = ls }
            typoMap[name] = entry
        }
        result["typography"] = typoMap

        return result
    }

    /// Export a theme to JSON data.
    public static func exportJSON(_ theme: Theme) throws -> Data {
        try JSONSerialization.data(withJSONObject: exportTheme(theme), options: [.prettyPrinted, .sortedKeys])
    }

    /// Import a theme from a JSON dictionary.
    public static func importTheme(from dict: [String: Any]) -> Theme? {
        guard let name = dict["name"] as? String else { return nil }

        var colors: [String: ColorToken] = [:]
        if let colorMap = dict["colors"] as? [String: [String: Any]] {
            for (key, value) in colorMap {
                if let hex = value["hex"] as? String, let token = ColorToken(hex: hex) {
                    colors[key] = token
                }
            }
        }

        var spacing: [String: SpacingToken] = [:]
        if let spacingMap = dict["spacing"] as? [String: Double] {
            for (key, value) in spacingMap {
                spacing[key] = SpacingToken(value)
            }
        }

        var typography: [String: TypographyToken] = [:]
        if let typoMap = dict["typography"] as? [String: [String: Any]] {
            for (key, value) in typoMap {
                guard let fontSize = value["fontSize"] as? Double else { continue }
                let weightStr = value["fontWeight"] as? String ?? "regular"
                let weight = FontWeight(rawValue: weightStr) ?? .regular
                let lineHeight = value["lineHeight"] as? Double
                let letterSpacing = value["letterSpacing"] as? Double
                typography[key] = TypographyToken(fontSize: fontSize, fontWeight: weight, lineHeight: lineHeight, letterSpacing: letterSpacing)
            }
        }

        return Theme(name: name, colors: colors, spacing: spacing, typography: typography)
    }

    /// Import a theme from JSON data.
    public static func importJSON(_ data: Data) -> Theme? {
        guard let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return nil }
        return importTheme(from: dict)
    }
}

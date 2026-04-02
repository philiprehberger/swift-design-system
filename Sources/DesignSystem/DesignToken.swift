import Foundation

/// A color represented as RGBA components (0-1 range).
public struct ColorToken: Sendable, Codable, Equatable {
    public let red: Double
    public let green: Double
    public let blue: Double
    public let alpha: Double

    public init(red: Double, green: Double, blue: Double, alpha: Double = 1.0) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }

    /// Create from hex string (e.g., "#FF5733" or "FF5733").
    public init?(hex: String) {
        var hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hex.hasPrefix("#") { hex.removeFirst() }
        guard hex.count == 6, let value = UInt64(hex, radix: 16) else { return nil }
        self.red = Double((value >> 16) & 0xFF) / 255.0
        self.green = Double((value >> 8) & 0xFF) / 255.0
        self.blue = Double(value & 0xFF) / 255.0
        self.alpha = 1.0
    }

    /// Return the hex string representation.
    public var hex: String {
        let r = Int(red * 255)
        let g = Int(green * 255)
        let b = Int(blue * 255)
        return String(format: "#%02X%02X%02X", r, g, b)
    }
}

/// A spacing value in points.
public struct SpacingToken: Sendable, Codable, Equatable {
    public let value: Double

    public init(_ value: Double) {
        self.value = value
    }
}

/// A typography style definition.
public struct TypographyToken: Sendable, Codable, Equatable {
    public let fontSize: Double
    public let fontWeight: FontWeight
    public let lineHeight: Double?
    public let letterSpacing: Double?

    public init(
        fontSize: Double,
        fontWeight: FontWeight = .regular,
        lineHeight: Double? = nil,
        letterSpacing: Double? = nil
    ) {
        self.fontSize = fontSize
        self.fontWeight = fontWeight
        self.lineHeight = lineHeight
        self.letterSpacing = letterSpacing
    }
}

/// Font weight options.
public enum FontWeight: String, Sendable, Codable, CaseIterable {
    case ultraLight
    case thin
    case light
    case regular
    case medium
    case semibold
    case bold
    case heavy
    case black
}

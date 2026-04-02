import Foundation

/// Severity level for validation issues.
public enum ValidationSeverity: String, Sendable {
    case warning
    case error
}

/// A single validation issue found during theme linting.
public struct ValidationIssue: Sendable {
    public let severity: ValidationSeverity
    public let message: String

    public init(severity: ValidationSeverity, message: String) {
        self.severity = severity
        self.message = message
    }
}

/// Validates design tokens for completeness and consistency.
public enum TokenValidator {
    /// Validate a theme against required token names.
    ///
    /// - Parameters:
    ///   - theme: The theme to validate.
    ///   - requiredColors: Color token names that must be present.
    ///   - requiredSpacing: Spacing token names that must be present.
    ///   - requiredTypography: Typography token names that must be present.
    /// - Returns: Array of validation issues found.
    public static func validate(
        _ theme: Theme,
        requiredColors: [String] = [],
        requiredSpacing: [String] = [],
        requiredTypography: [String] = []
    ) -> [ValidationIssue] {
        var issues: [ValidationIssue] = []

        for name in requiredColors where theme.color(name) == nil {
            issues.append(ValidationIssue(severity: .error, message: "Missing required color: \(name)"))
        }

        for name in requiredSpacing where theme.spacing(name) == nil {
            issues.append(ValidationIssue(severity: .error, message: "Missing required spacing: \(name)"))
        }

        for name in requiredTypography where theme.typography(name) == nil {
            issues.append(ValidationIssue(severity: .error, message: "Missing required typography: \(name)"))
        }

        if theme.colors.isEmpty {
            issues.append(ValidationIssue(severity: .warning, message: "Theme has no color tokens"))
        }

        if theme.spacing.isEmpty {
            issues.append(ValidationIssue(severity: .warning, message: "Theme has no spacing tokens"))
        }

        if theme.typography.isEmpty {
            issues.append(ValidationIssue(severity: .warning, message: "Theme has no typography tokens"))
        }

        return issues
    }
}

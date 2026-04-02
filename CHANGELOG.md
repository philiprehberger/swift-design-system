# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - 2026-04-02

### Added
- `DesignSystem` singleton facade with theme, component, and token access
- `Theme` value type with named color, spacing, and typography tokens
- `ThemeManager` with registration, switching, and observer notifications
- `ComponentRegistry` for named component style configurations
- `TokenExporter` for JSON export/import (Figma bridge)
- `ColorToken` with hex parsing and RGBA components
- `SpacingToken` and `TypographyToken` value types
- Zero external dependencies

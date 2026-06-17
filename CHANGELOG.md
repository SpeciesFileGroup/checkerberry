# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.0.2] - 2026-06-17

### Changed
- Relaxed `required_ruby_version` to `>= 2.5.0, < 5.0` to allow Ruby 4.0.0
- Added Ruby 4.0.0 to the CI matrix (now `['3.3.4', '4.0.0']`)
- Added GitHub Actions workflow (none existed before)
- Dropped the `bundler` development dependency
- Added `irb` development dependency (no longer in stdlib on Ruby 4)
- Untracked VCR cassettes so CI re-records against the live GNverifier API on every run

## [0.0.1] - 2025-10-22

### Added
- Initial release
- GNverifier API wrapper based on colrapi structure
- Verify scientific names endpoint
- Data sources listing endpoint
- Version information endpoint
- Basic test suite with VCR cassettes

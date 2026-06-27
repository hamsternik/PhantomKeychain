# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2026-06-27

Initial public release.

### Added

- `KeychainKey<Value>` — phantom-typed keys that carry their value's type at compile time.
- `KeychainStore` protocol — `set` / `get` / `remove` / `clear` over typed keys.
- `KeychainStorable` protocol with built-in conformances for `String`, `Data`, and `Bool`.
- `KeychainStoreLive` — production store backed by [KeychainSwift](https://github.com/evgenyneu/keychain-swift),
  using `kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly` and a configurable `keyPrefix`.
- `KeychainStoreInMemory` — thread-safe, Keychain-free test double with identical behavior.
- Swift Package Manager support for iOS 16+, macOS 13+, and watchOS 9+ (Swift 5.9).

[0.1.0]: https://github.com/hamsternik/PhantomKeychain/releases/tag/0.1.0

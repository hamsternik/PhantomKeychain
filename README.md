# PhantomKeychain

A tiny, type-safe Keychain wrapper for Swift. Store secrets behind **phantom-typed keys** so the compiler — not you — keeps track of what type lives at each key.

![Swift](https://img.shields.io/badge/Swift-5.9+-orange.svg)
![Platforms](https://img.shields.io/badge/Platforms-iOS%20%7C%20macOS%20%7C%20watchOS-lightgrey.svg)
![License](https://img.shields.io/badge/License-MIT-blue.svg)

## Why

The Keychain API is stringly-typed: you write `Data`, you read `Data`, and you're
left to remember what was supposed to live at each key. `PhantomKeychain` gives you
`KeychainKey<Value>` — a key that carries its value's type at compile time:

```swift
let token = KeychainKey<String>(name: "auth_token")

store.set("abc", forKey: token)              // ✅ String in
let value: String? = store.get(forKey: token) // ✅ String out, no casting
store.set(true, forKey: token)               // ❌ won't compile — `token` is a String key
```

## Install

Swift Package Manager — add the dependency to your `Package.swift`:

```swift
.package(url: "https://github.com/hamsternik/PhantomKeychain.git", from: "0.1.0"),
```

then add `PhantomKeychain` to your target:

```swift
.product(name: "PhantomKeychain", package: "PhantomKeychain"),
```

## Usage

```swift
import PhantomKeychain

let store: KeychainStore = KeychainStoreLive(keyPrefix: "com.yourapp.")

let apiToken = KeychainKey<String>(name: "api_token")

store.set("s3cr3t", forKey: apiToken)     // -> Bool
let token = store.get(forKey: apiToken)   // -> String?
store.remove(by: apiToken)                // -> Bool
store.clear()                             // wipe everything under the prefix
```

`String`, `Data`, and `Bool` are storable out of the box. Conform your own types to
`KeychainStorable` (a `var keychainData: Data` getter plus an `init?(keychainData:)`)
to store them too.

### Testing

Swap in `KeychainStoreInMemory` — a thread-safe, Keychain-free double with identical
behavior — so your tests never touch the system Keychain:

```swift
let store: KeychainStore = KeychainStoreInMemory()
```

## Details

- **Access**: items use `kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly` — readable
  after first unlock, never synced to iCloud or restored to another device.
- **Prefix**: keys are namespaced by `keyPrefix`. Pass your own to isolate your app's
  items from anything else in the Keychain.
- **Backing**: `0.1.0` is built on [KeychainSwift](https://github.com/evgenyneu/keychain-swift).
  `0.2.0` will drop it for a zero-dependency `Security`/`SecItem` implementation — with
  the same public API.

## Roadmap

- [ ] Publish a [GitHub Release](https://github.com/hamsternik/PhantomKeychain/releases) with notes for `0.2.0` (skipped for `0.1.0`).
- [ ] Register the package on [Swift Package Index](https://swiftpackageindex.com) for discoverability.
- [ ] Add an example project demonstrating real-world integration of the library in an app.
- [ ] Expand CI to a full test matrix across every supported platform/OS/device (currently only `swift test` on the macOS host). Reference: [KeychainAccess `test.yml`](https://github.com/kishikawakatsumi/KeychainAccess/blob/master/.github/workflows/test.yml) — matrix over macOS runners × Xcode versions × simulator OS versions × device models, with `xcodebuild test` per destination.

## Requirements

- Swift 5.9+
- iOS 16+ · macOS 13+ · watchOS 9+

## License

MIT © 2026 Mykyta Khomitsevych

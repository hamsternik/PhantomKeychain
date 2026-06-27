// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PhantomKeychain",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .watchOS(.v9),
        
        // tvOS omitted: SecItem compiles, but tvOS has not persistent on-device Keychain.
        // Items are not guaranteed to survive termination/reboot, and `...ThisDeviceOnly`
        // access opts out in the iCloud fallback. Back to this later on!
        // .tvOS(.v16),
        
        // visionOS ommited: Keychain works b/c the OS is iOS-based, but untested and
        // out of CI/CD pipeline. Re-enable once there is a verified build/test pipeline.
        // btw visionOS does require swift-tools-version >= 5.9. Back to this later on!
        // .visionOS(.v1),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "PhantomKeychain",
            targets: ["PhantomKeychain"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/evgenyneu/keychain-swift.git", from: "24.0.0"),
    ],
    targets: [
        .target(
            name: "PhantomKeychain",
            dependencies: [
                .product(name: "KeychainSwift", package: "keychain-swift"),
            ]
        ),
        .testTarget(
            name: "PhantomKeychainTests",
            dependencies: ["PhantomKeychain"]
        ),
    ]
)

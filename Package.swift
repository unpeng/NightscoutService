// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NightscoutService",
    defaultLocalization: "en",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "NightscoutServiceKit",targets: ["NightscoutServiceKit"]),
        .library(name: "NightscoutServiceKitUI",targets: ["NightscoutServiceKitUI"]),
        .library(name: "NightscoutServiceKitPlugin",targets: ["NightscoutServiceKitPlugin"]),
    ],
    dependencies: [
        .package(url: "https://github.com/LoopKit/LoopKit.git", .branch("package-experiment")),
        .package(name: "RileyLinkIOS", url: "https://github.com/ps2/rileylink_ios.git", .branch("package-experiment"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "NightscoutServiceKit",
            dependencies: [ "LoopKit" ],
            exclude: ["Info.plist"]
        ),
        .target(
            name: "NightscoutServiceKitUI",
            dependencies: [
                "NightscoutServiceKit",
                .product(name: "NightscoutUploadKit", package: "RileyLinkIOS"),
                "LoopKit",
                .product(name: "LoopKitUI", package: "LoopKit")
            ],
            exclude: ["Info.plist"]
        ),
        .target(
            name: "NightscoutServiceKitPlugin",
            dependencies: [ "NightscoutServiceKitUI" ],
            exclude: ["Info.plist"]
        ),
        .testTarget(
            name: "NightscoutServiceKitTests",
            dependencies: ["NightscoutServiceKit"],
            exclude: ["Info.plist"]
        ),
        .testTarget(
            name: "NightscoutServiceKitUITests",
            dependencies: ["NightscoutServiceKit"],
            exclude: ["Info.plist"]
        )
    ]
)

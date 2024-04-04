// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "CoffeeSnob",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "CoffeeSnob", targets: ["CoffeeSnob"]),
    ],
    dependencies: [
        .package(url: "https://github.com/tomtom-international/tomtom-sdk-spm-navigation", exact: "0.44.1")
    ],
    .package(url: "https://github.com/tomtom-international/tomtom-sdk-spm-core", exact: "0.44.1")
    
    targets: [
       .target(name: "CoffeeSnob", dependencies: [
            .product(name: "TomTomSDKNavigation", package: "tomtom-sdk-spm-navigation")
            /* add more products here */
                .product(name: "TomTomSDKCommon", package: "tomtom-sdk-spm-core")
       ]),
    ]
)

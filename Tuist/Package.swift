// swift-tools-version: 5.9
@preconcurrency import PackageDescription

#if TUIST
import ProjectDescription
import ProjectDescriptionHelpers

let packageSettings = Project.makePackageSettings()
#endif

let package = Package(
    name: "Package",
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk", from: "10.28.0")
    ]
)

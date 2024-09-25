import ProjectDescription

// MARK: - Settings

extension Project {
    public static func makeProjectSettings() -> Settings {
        .settings(
            base: [
                "DEBUG_INFORMATION_FORMAT": "dwarf-with-dsym",
                "ENABLE_USER_SCRIPT_SANDBOXING": false,
                "ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS": true,
                "OTHER_LDFLAGS": "$(inherited) -ObjC"
            ],
            configurations: [
                .debug(name: "Debug"),
                .release(
                    name: "Release",
                    settings: [
                        "SWIFT_ACTIVE_COMPILATION_CONDITIONS": "RELEASE"
                    ]
                ),
                .release(
                    name: "AdHoc",
                    settings: [
                        "SWIFT_ACTIVE_COMPILATION_CONDITIONS": "ADHOC"
                    ]
                )
            ]
        )
    }

    public static func makePackageSettings() -> PackageSettings {
        PackageSettings(
            baseSettings: .settings(
                configurations: [
                    .debug(name: "Debug"),
                    .release(name: "Release"),
                    .release(name: "AdHoc")
                ]
            )
        )
    }

    public static func makeMainTargetSettings(marketingVersion: String, currentProjectVersion: String) -> Settings {
        .settings(
            base: [
                "INFOPLIST_KEY_CFBundleDisplayName": "DemoFirebase",
                "MARKETING_VERSION": SettingValue(stringLiteral: marketingVersion),
                "CURRENT_PROJECT_VERSION": SettingValue(stringLiteral: currentProjectVersion),
                "DEVELOPMENT_TEAM": "F6J8B455GU",
                "CODE_SIGN_STYLE": "Manual"
            ],
            configurations: [
               .debug(
                   name: "Debug",
                   settings: [
                       "CODE_SIGN_IDENTITY": "iPhone Developer",
                       "PROVISIONING_PROFILE_SPECIFIER": "match Development demo-firebase"
                   ],
                   xcconfig: nil
               ),
               .release(
                   name: "AdHoc",
                   settings: [
                       "CODE_SIGN_IDENTITY": "iPhone Distribution",
                       "PROVISIONING_PROFILE_SPECIFIER": "match AdHoc demo-firebase"
                   ],
                   xcconfig: nil
               ),
               .release(
                   name: "Release",
                   settings: [
                       "CODE_SIGN_IDENTITY": "iPhone Distribution",
                       "PROVISIONING_PROFILE_SPECIFIER": "match AppStore demo-firebase"
                   ],
                   xcconfig: nil
               )
           ],
           defaultSettings: .recommended
        )
    }
}

// MARK: - Plists

extension Project {
    public static func makeMainPlist(marketingVersion: String, currentProjectVersion: String) -> InfoPlist {
        .extendingDefault(
            with: [
                "CFBundleShortVersionString": Plist.Value(stringLiteral: marketingVersion),
                "CFBundleVersion": Plist.Value(stringLiteral: currentProjectVersion),
                "UIRequiresFullScreen": true,
                "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"],
                "FirebaseAppDelegateProxyEnabled": false,
                "UILaunchStoryboardName": "LaunchScreen.storyboard",
                "UIAppFonts": [
                    // Add fonts here
                    // "Figtree-Black.ttf"
                ]
            ]
        )
    }
}

// MARK: - Sources

extension Project {
    public static func makeMainSources() -> SourceFilesList {
        [
            "DemoFirebase/**"
        ]
    }
}

// MARK: - Resources

extension Project {
    public static func makeMainResources() -> ResourceFileElements {
        [
            "DemoFirebase/Assets.xcassets",
            "DemoFirebase/LaunchScreen.storyboard",
            "DemoFirebase/Preview Content/Preview Assets.xcassets",
            "PrivacyInfo.xcprivacy"

            // Include other non-swift files here as needed
            // "GoogleService-Info.plist"
        ]
    }
}

// MARK: - Dependencies

extension Project {
    public static func makeMainDependencies() -> [TargetDependency] {
        [
            .external(name: "FirebaseAnalytics"),
            .external(name: "FirebaseCrashlytics")
        ]
    }
}

// MARK: - Scripts

extension Project {
    public static func makeSwiftLintScript() -> TargetScript {
        TargetScript.pre(
            script:
                """
                if [ -z "$CI" ] || ! $CI ; then
                    if test -d "/opt/homebrew/bin/"; then
                      PATH="/opt/homebrew/bin/:${PATH}"
                    fi\n
                    # -C ensures that Mise loads the configuration from the Mise configuration
                    # file in the project's root directory.
                    eval "$(mise activate -C $SRCROOT bash --shims)"
                    mise exec -- swiftlint
                fi
                """,
            name: "SwiftLint",
            basedOnDependencyAnalysis: false
        )
    }
}

import ProjectDescription
import ProjectDescriptionHelpers

let marketingVersion = "1.0.0"
let currentProjectVersion = "1"
let deploymentTargets = DeploymentTargets.iOS("17.0")
let destinations: Destinations = [.iPhone]

let mainTarget = Target.target(
    name: "DemoFirebase",
    destinations: destinations,
    product: .app,
    productName: "DemoFirebase",
    bundleId: "demo-firebase",
    deploymentTargets: deploymentTargets,
    infoPlist: Project.makeMainPlist(
        marketingVersion: marketingVersion,
        currentProjectVersion: currentProjectVersion
    ),
    sources: Project.makeMainSources(),
    resources: Project.makeMainResources(),
    scripts: [
        Project.makeSwiftLintScript()
    ],
    dependencies: Project.makeMainDependencies(),
    settings: Project.makeMainTargetSettings(
        marketingVersion: marketingVersion,
        currentProjectVersion: currentProjectVersion
    )
)

let project = Project(
    name: "DemoFirebase",
    organizationName: "Keke Arif",
    settings: Project.makeProjectSettings(),
    targets: [mainTarget]
)

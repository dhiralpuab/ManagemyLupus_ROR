# ManageMyLupus iOS App

Native iOS app shell using Turbo Native to display the Rails web app.

## Setup

### 1. Create Xcode Project

1. Open Xcode and create a new iOS App project
2. Name it "ManageMyLupus"
3. Select Swift as the language
4. Select Storyboard as the interface (we'll remove it)

### 2. Add Turbo Native Dependency

Via Swift Package Manager:
1. File > Add Packages...
2. Enter: `https://github.com/hotwired/turbo-ios`
3. Select version: Up to Next Major (7.0.0 or later)
4. Add to target: ManageMyLupus

### 3. Copy Source Files

Copy all files from this directory structure into your Xcode project:
- `App/AppDelegate.swift`
- `App/SceneDelegate.swift`
- `Navigation/TurboNavigator.swift`
- `Controllers/VisitableViewController.swift`
- `Resources/path-configuration.json`

### 4. Configure Info.plist

Add deep linking support:

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLName</key>
        <string>com.yourcompany.managemylupus</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>managemylupus</string>
        </array>
    </dict>
</array>
```

### 5. Update Base URL

In `Navigation/TurboNavigator.swift`, update the base URL:

```swift
enum TurboConfig {
    static let baseURL = "https://your-production-url.com"
}
```

### 6. App Icons

Add your app icons to `Assets.xcassets/AppIcon.appiconset/`

Required sizes:
- 1024x1024 (App Store)
- 180x180 (@3x iPhone)
- 120x120 (@2x iPhone)
- 167x167 (@2x iPad Pro)
- 152x152 (@2x iPad)

## Build and Run

1. Select your target device or simulator
2. Press Cmd+R to build and run
3. The app will load your Rails app in a native wrapper

## Features

- Native navigation (push/pop)
- Modal presentation for card details
- Pull-to-refresh on survey pages
- Deep linking support
- Session cookie persistence

## Deployment

1. Configure signing in Xcode
2. Archive: Product > Archive
3. Submit via App Store Connect

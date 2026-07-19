# ManageMyLupus Android App

Native Android app shell using Turbo Native to display the Rails web app.

## Setup

### 1. Open in Android Studio

1. Open Android Studio
2. File > Open > Select the `ManageMyLupus-Android` folder
3. Wait for Gradle sync to complete

### 2. Update Base URL

In `app/src/main/java/com/managemylupus/app/TurboApplication.kt`, update the base URL:

```kotlin
companion object {
    const val BASE_URL = "https://your-production-url.com"
}
```

Also update the host in `AndroidManifest.xml` for App Links:

```xml
<data
    android:scheme="https"
    android:host="your-production-url.com"
    android:pathPattern="/.*" />
```

### 3. App Icons

Replace the default icons in:
- `app/src/main/res/mipmap-mdpi/`
- `app/src/main/res/mipmap-hdpi/`
- `app/src/main/res/mipmap-xhdpi/`
- `app/src/main/res/mipmap-xxhdpi/`
- `app/src/main/res/mipmap-xxxhdpi/`

Use Android Studio's Image Asset Studio: Right-click `res` > New > Image Asset

## Build and Run

1. Select a device or emulator
2. Click Run (green play button) or press Shift+F10
3. The app will load your Rails app in a native wrapper

## Features

- Native navigation (push/pop)
- Bottom sheet dialogs for card details
- Pull-to-refresh on survey pages
- Deep linking support (`managemylupus://` scheme)
- App Links for `https://` URLs
- Session cookie persistence

## Project Structure

```
app/src/main/
├── java/com/managemylupus/app/
│   ├── TurboApplication.kt      # Application class with Turbo config
│   ├── MainActivity.kt          # Main activity with deep link handling
│   ├── MainSessionNavHostFragment.kt  # Turbo session management
│   ├── WebFragment.kt           # Default web fragment with pull-to-refresh
│   └── WebBottomSheetDialogFragment.kt  # Modal fragment for card details
├── res/
│   ├── layout/
│   │   ├── activity_main.xml
│   │   ├── fragment_web.xml
│   │   └── fragment_web_bottom_sheet.xml
│   ├── navigation/nav_graph.xml
│   ├── raw/path_configuration.json
│   └── values/
│       ├── colors.xml
│       ├── strings.xml
│       └── themes.xml
└── AndroidManifest.xml
```

## Deployment

1. Generate signed APK/AAB:
   - Build > Generate Signed Bundle/APK
   - Create or use existing keystore
   - Select release build variant

2. Submit to Google Play Console

## App Links Setup

For App Links to work (automatic deep link handling), you need to:

1. Create `assetlinks.json` file:
```json
[{
  "relation": ["delegate_permission/common.handle_all_urls"],
  "target": {
    "namespace": "android_app",
    "package_name": "com.managemylupus.app",
    "sha256_cert_fingerprints": ["YOUR_APP_SIGNING_CERT_SHA256"]
  }
}]
```

2. Host it at: `https://your-rails-app.com/.well-known/assetlinks.json`

3. Get your signing cert fingerprint:
```bash
keytool -list -v -keystore your-keystore.jks -alias your-alias
```

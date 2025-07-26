# Dhikr App

A simple and focused dhikr app.

## Pre-requisites

Before you begin, ensure you have the following installed:
- [Flutter](https://flutter.dev/docs/get-started/install) (3.2.6 or higher)
- [Dart](https://dart.dev/get-dart) (3.2.6 or higher)
- [Android Studio](https://developer.android.com/studio) (for Android development)
- [Xcode](https://developer.apple.com/xcode/) (for iOS development, macOS only)
- [JDK](https://www.oracle.com/java/technologies/downloads/) (version 21 or higher)
- [Git](https://git-scm.com/downloads) (for version control)
- [VS Code](https://code.visualstudio.com/) (recommended editor) with the following extensions:
  - Flutter extension
  - Dart extension

### System Requirements
- Operating System: Windows/macOS/Linux
- RAM: 8GB minimum (16GB recommended)
- Storage: At least 5GB of free space
- Android SDK (for Android development)
- iOS SDK (for iOS development, macOS only)

### Environment Setup
1. Add Flutter to your PATH
2. Run `flutter doctor` to verify installations
3. Accept Android licenses with `flutter doctor --android-licenses`
4. Configure your IDE/editor with Flutter/Dart plugins

## flutter_launcher_icons
Source : [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons)
to run the package, run the following command in the terminal:
```bash
flutter pub get
dart run flutter_launcher_icons
```

## Flutter Build Setup

- Setup `keytool` from `jdk/bin` directory to your `PATH` environment variable.
- Run the following command to generate a keystore:
```bash
keytool -genkey -v -keystore $env:USERPROFILE\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```
- This will prompt you to enter a password and some information about the keystore. Make sure to remember the password as you will need it later.
- Once the keystore is generated, you can use it to sign your Flutter app for release. To do this, you will need to create a `key.properties` file in the root of your Flutter project with the following content:
```properties
storePassword=your_store_password
keyPassword=your_key_password
keyAlias=your_key_alias
storeFile=path_to_your_keystore_file
```
- Replace the placeholders with the actual values you used when generating the keystore.
- Make sure to add the `key.properties` file to your `.gitignore` file to keep it private.
- In your `android/app/build.gradle` file, add the following code to the `android` block:
```groovy
// KeyStore Properties
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile file(keystoreProperties['storeFile'])
            storePassword keystoreProperties['storePassword']
        }
    }
}
```
- Finally, you can build your Flutter app for release using the following command:
```bash
flutter build appbundle --release
```
- This will generate a signed AAB file in the `build/app/outputs/bundle/release` directory.
- You can then upload this AAB file to the Google Play Console for distribution.
- If you want to build an APK instead of an AAB, you can use the following command:
```bash
flutter build apk --release
```
- This will generate a signed APK file in the `build/app/outputs/flutter-apk` directory.

Useful Links:
- [Flutter Build Setup](https://docs.flutter.dev/deployment/android)

## Google AdMob Integration
- Create an AdMob account and set up your app in the AdMob console [here](https://admob.google.com/home/).
- Create a new app in the AdMob console and get your App ID, here is the [documentation](https://docs.flutter.dev/cookbook/plugins/google-mobile-ads).
- Install the required packages:
```bash
flutter pub add google_mobile_ads
flutter pub add flutter_dotenv
```
- Create a `.env` file in the root of your project with the following content:
```properties
ANDROID_BANNER_AD_UNIT_ID=ca-app-pub-xxxxxxxxxxxxxxxx/yyyyyyyyyy
IOS_BANNER_AD_UNIT_ID=ca-app-pub-xxxxxxxxxxxxxxxx/yyyyyyyyyy
ANDROID_ADMOB_APP_ID=ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyyyy
IOS_ADMOB_APP_ID=ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyyyy
```
- Replace the placeholder values with your actual AdMob IDs
- Make sure to add `.env` to your `.gitignore` file to keep your AdMob IDs private
- Create a `.env.example` file with placeholder values to show other developers what environment variables are needed
- Add the .env file to your assets in pubspec.yaml:
```yaml
flutter:
  assets:
    - .env
    # ... other assets
```
- Add the App ID to your `main/AndroidManifest.xml` file:
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <application
        android:label="Dhikr App"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">

        <meta-data
            android:name="com.google.android.gms.ads.APPLICATION_ID"
            android:value="ca-app-pub-xxxxxxxxxxx~xxxxxxxxx" />
    </application>
</manifest>
```
- Create AdHelper class to manage UnitID check it [here](lib/helpers/ad_helper.dart).
- Remember, here is the important setup for UnitID :
  - For local testing, use this unit ID: `ca-app-pub-3940256099942544/9214589741'`
  - For production, use your own unit ID from AdMob.
- Use this method to call the UnitID in your widget:
```dart
void _loadBannerAd() async {
    final ad = BannerAd(
      adUnitId: await AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) => setState(() {}),
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('Ad failed to load: $error');
        },
      ),
    );
    ad.load();

    setState(() {
      bannerAd = ad;
    });
  }
```
- Example of using the banner ad in your widget:
```dart
...
    if (bannerAd != null)
        SizedBox(
        height: bannerAd!.size.height.toDouble(),
        width: bannerAd!.size.width.toDouble(),
        child: AdWidget(ad: bannerAd!),
    ),
...
```

## Project Structure

```
dhikr_app/
├── android/                    # Android-specific configuration and code
├── ios/                       # iOS-specific configuration and code
├── assets/                    # Static assets used in the app
│   ├── dhikr/                # JSON files for dhikr content
│   │   ├── evening/          # Evening dhikr data
│   │   └── morning/          # Morning dhikr data
│   ├── fonts/                # Custom fonts (AmiriQuran)
│   ├── icons/                # App icons
│   ├── lang/                 # Localization files (en.json, id.json)
│   └── logo/                 # App logo assets
├── lib/                      # Main Dart source code
│   ├── helpers/              # Helper classes and utilities
│   ├── models/               # Data models and classes
│   ├── pages/                # Screen/Page widgets
│   ├── service/              # Business logic and services
│   ├── shared/               # Shared utilities and constants
│   ├── static/               # Static data and configurations
│   ├── widget/               # Reusable UI components
│   └── main.dart            # Application entry point
├── test/                    # Test files
├── .env                     # Environment variables (not in repo)
├── .env.example            # Example environment variables
├── pubspec.yaml            # Project dependencies and configuration
└── README.md              # Project documentation
```

### Key Directories and Files

- **lib/**: Contains the main Dart source code
  - `helpers/`: Utility classes like AdHelper for AdMob integration
  - `models/`: Data models for the application
  - `pages/`: Main screen implementations
  - `service/`: Business logic, state management, and external services
  - `shared/`: Common utilities and constants used across the app
  - `widget/`: Reusable UI components

- **assets/**: Contains all static resources
  - `dhikr/`: JSON files containing dhikr content in different languages
  - `lang/`: Localization files for multiple languages
  - `fonts/`: Custom fonts used in the app
  - `logo/`: App logo and branding assets

- **android/ & ios/**: Platform-specific configurations
  - Contains necessary setup for AdMob, notifications, and other native features

- **Configuration Files**:
  - `.env`: Contains sensitive configuration (AdMob IDs, API keys)
  - `pubspec.yaml`: Project dependencies and asset declarations
  - `analysis_options.yaml`: Dart analyzer settings

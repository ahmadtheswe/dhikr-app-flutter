# Dhikr App

A simple and focused dhikr app.

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
- Install the `google_mobile_ads`
```bash
flutter pub add google_mobile_ads
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

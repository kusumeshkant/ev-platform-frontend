# Release Guide — Flutter Apps

---

## Android Release Build

### 1. Generate Keystore (one-time)

```bash
keytool -genkey -v \
  -keystore release.jks \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000 \
  -alias ev_platform
```

Store `release.jks` securely — **never commit it**.

### 2. Configure Signing

Create `apps/rider_app/android/key.properties`:

```properties
storePassword=<your-store-password>
keyPassword=<your-key-password>
keyAlias=ev_platform
storeFile=../../../keys/release.jks
```

Add to `apps/rider_app/android/app/build.gradle`:

```groovy
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
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            shrinkResources true
        }
    }
}
```

### 3. Build Release APK / AAB

```bash
cd apps/rider_app

# Inject brand first
cp ../../brands/brand_ecobike/brand.json assets/brand/brand.json

# APK (for direct distribution)
flutter build apk --release

# AAB (for Play Store)
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

---

## iOS Release Build

### Prerequisites
- macOS + Xcode 15+
- Apple Developer account
- Provisioning profile + certificate

```bash
cd apps/rider_app
flutter build ipa --release
```

Upload `build/ios/ipa/*.ipa` via Xcode Organizer or `xcrun altool`.

---

## Web Release (admin_panel)

```bash
cd apps/admin_panel
flutter build web --release --base-href /admin/

# Upload build/web/ to your CDN/server
```

---

## Versioning

Update version in each app's `pubspec.yaml`:

```yaml
version: 1.2.0+5   # format: semver+buildNumber
```

Tag the release in git:

```bash
git tag -a v1.2.0 -m "Release 1.2.0"
git push origin v1.2.0
```

---

## Branch Strategy

| Branch | Purpose |
|--------|---------|
| `main` | Stable, production-tagged releases only |
| `develop` | Active development, all PRs merge here |
| `feature/*` | Feature branches, PR → develop |
| `hotfix/*` | Critical fixes, PR → main + develop |

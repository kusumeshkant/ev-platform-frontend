# Android Release — Step-by-Step

---

## First Time Setup (Per Brand / Client)

### 1. Create Keystore

```bash
keytool -genkey -v \
  -keystore keys/ecobike-release.jks \
  -alias ecobike \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000
```

When prompted:
- First/Last name: `EcoBike App`
- Organization unit: `Mobile`
- Organization: `EcoBike Technologies`
- City, State, Country: your details

**Store the keystore and passwords in a secure vault (1Password / Bitwarden). If lost, you cannot update your Play Store app.**

### 2. Create `key.properties`

Create `apps/rider_app/android/key.properties` (gitignored):

```properties
storePassword=YOUR_STORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=ecobike
storeFile=../../../../keys/ecobike-release.jks
```

### 3. Configure Gradle Signing

In `apps/rider_app/android/app/build.gradle`, inside `android {}`:

```groovy
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

signingConfigs {
    release {
        keyAlias keystoreProperties['keyAlias']
        keyPassword keystoreProperties['keyPassword']
        storeFile file(keystoreProperties['storeFile'])
        storePassword keystoreProperties['storePassword']
    }
}

buildTypes {
    release {
        signingConfig signingConfigs.release
        minifyEnabled true
        shrinkResources true
        proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
    }
}
```

---

## Build Release AAB (Play Store)

```bash
# 1. Update version in pubspec.yaml
#    version: 1.2.0+5  (semver + build number)

# 2. Inject brand
cp brands/brand_ecobike/brand.json apps/rider_app/assets/brand/brand.json

# 3. Run code gen if needed
cd apps/rider_app
dart run build_runner build --delete-conflicting-outputs

# 4. Build AAB
flutter build appbundle --release

# Output: build/app/outputs/bundle/release/app-release.aab
```

---

## Play Store Submission Checklist

- [ ] Increment `versionCode` (build number) in `pubspec.yaml`
- [ ] Test on real device (not just emulator)
- [ ] Test all payment flows with test cards
- [ ] Screenshot all required screen sizes
- [ ] Update Play Store description if changed
- [ ] Check `google-services.json` is correct for production (not staging)
- [ ] Upload AAB to Play Console → Internal Testing first → then Production

---

## CI/CD Signing (GitHub Actions)

Store secrets in GitHub:
- `KEYSTORE_BASE64` — base64-encoded JKS file: `base64 -i release.jks`
- `KEY_ALIAS` — alias name
- `KEY_PASSWORD` — key password
- `STORE_PASSWORD` — store password

In workflow:
```yaml
- name: Decode keystore
  run: echo "${{ secrets.KEYSTORE_BASE64 }}" | base64 -d > release.jks

- name: Build AAB
  run: flutter build appbundle --release
  env:
    KEY_ALIAS: ${{ secrets.KEY_ALIAS }}
    KEY_PASSWORD: ${{ secrets.KEY_PASSWORD }}
    STORE_PASSWORD: ${{ secrets.STORE_PASSWORD }}
```

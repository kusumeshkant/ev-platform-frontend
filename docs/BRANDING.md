# Branding Guide — Multi-Tenant White-Label

The platform supports multiple brands (clients) from a single codebase.  
Each brand is a JSON config file injected at build time.

---

## Brand Config Structure

Located in `brands/<brand-name>/brand.json`:

```json
{
  "brandId": "ecobike",
  "appName": "EcoBike",
  "tagline": "Ride Green, Ride Smart",
  "primaryColor": "0xFF00C853",
  "primaryDarkColor": "0xFF009624",
  "primaryLightColor": "0xFF5EFC82",
  "secondaryColor": "0xFF1565C0",
  "fontFamily": "Poppins",
  "logoFile": "logo.svg",
  "supportEmail": "support@ecobike.in",
  "currency": "INR",
  "currencySymbol": "₹",
  "defaultLocale": "en",
  "features": {
    "enableRazorpay": true,
    "enableWallet": true,
    "enableSOS": true,
    "enableDynamicPricing": false
  }
}
```

---

## How to Add a New Brand

1. Create `brands/brand_<clientname>/brand.json`
2. Fill in colors (hex as `0xFFRRGGBB`), app name, logo filenames, feature flags
3. Prepare assets: `logo.svg`, `logo_dark.svg`, `splash.png`

---

## How to Build for a Specific Brand

```bash
# Step 1 — inject brand config
cp brands/brand_ecobike/brand.json apps/rider_app/assets/brand/brand.json

# Step 2 — inject logo assets (place in apps/<app>/assets/images/)
cp brands/brand_ecobike/logo.svg apps/rider_app/assets/images/logo.svg

# Step 3 — build
cd apps/rider_app
flutter build apk --release
```

### CI/CD Brand Injection

In GitHub Actions, inject via a secret:

```yaml
- name: Inject brand
  run: |
    echo '${{ secrets.BRAND_JSON_ECOBIKE }}' > apps/rider_app/assets/brand/brand.json
```

---

## Feature Flags

| Flag | Effect |
|------|--------|
| `enableRazorpay` | Shows Razorpay payment in wallet topup |
| `enableWallet` | Enables wallet tab and balance display |
| `enableSOS` | Shows SOS button on active ride screen |
| `enableDynamicPricing` | Shows surge pricing badge on vehicles |
| `enableReferrals` | Shows referral code section in profile |
| `enableSubscriptions` | Shows subscription plans in profile |

Access in code via `BrandConfig.current.features.enableRazorpay`.

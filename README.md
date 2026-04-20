# EV Platform — Frontend

Flutter monorepo powering the EV scooter rental platform.  
Contains three apps and six shared packages managed via [Melos](https://melos.invertase.dev/).

---

## Apps

| App | Platform | Description |
|-----|----------|-------------|
| `apps/rider_app` | Android / iOS | End-rider app — find, unlock, and ride scooters |
| `apps/hub_app` | Android / iOS | Hub operator app — fleet management, QR scanning |
| `apps/admin_panel` | Web / Desktop | Admin dashboard — KPIs, fleet, rides, users |

## Shared Packages

| Package | Description |
|---------|-------------|
| `packages/design_system` | Colors, typography, spacing, theme engine |
| `packages/brand_config` | Multi-tenant brand loader (white-label support) |
| `packages/assets_registry` | Centralised SVG / icon / image references |
| `packages/core_flutter` | ApiClient, DI, Failure hierarchy, token storage |
| `packages/localization` | ARB strings (en, hi, ta, te, kn), LocaleBloc |
| `packages/shared_ui` | Brand-aware reusable widget library |

---

## Prerequisites

- Flutter `>=3.19.0`
- Dart `>=3.3.0`
- [Melos](https://melos.invertase.dev/) `^6.1.0`

```bash
dart pub global activate melos
```

---

## Setup

```bash
# 1. Clone
git clone https://github.com/kusumeshkant/ev-platform-frontend.git
cd ev-platform-frontend

# 2. Bootstrap all packages
melos bootstrap

# 3. Generate localization files
melos run gen

# 4. (Optional) Run code generation for rider_app
melos run build:runner
```

---

## Running Apps

### Rider App
```bash
cd apps/rider_app
flutter run
```

### Hub App
```bash
cd apps/hub_app
flutter run
```

### Admin Panel (Web)
```bash
cd apps/admin_panel
flutter run -d chrome
```

---

## Brand Injection

Brand assets are **not committed**. Before running, inject a brand config:

```bash
# Copy a brand from the brands/ directory
cp -r brands/brand_ecobike/brand.json apps/rider_app/assets/brand/brand.json
```

CI/CD injects brand assets at build time via environment-specific brand bundles.

---

## Useful Melos Commands

```bash
melos analyze        # flutter analyze all packages
melos test           # flutter test all packages
melos format         # dart format check
melos gen            # generate localization
melos build:runner   # run build_runner
melos clean          # flutter clean all
```

---

## Backend

API backend lives in a separate repo:  
👉 [ev-platform-backend](https://github.com/kusumeshkant/ev-platform-backend)

Update `packages/core_flutter/lib/src/network/api_constants.dart` with the backend URL before running.

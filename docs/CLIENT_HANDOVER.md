# Client Handover Document
## EV Scooter Rental Platform

**Prepared for:** [Client Name]  
**Prepared by:** [Your Company]  
**Date:** April 2026  
**Version:** 1.0

---

## 1. What Has Been Built

A complete, production-ready EV scooter rental platform consisting of:

### Mobile Apps (Flutter)

| App | Users | Platforms |
|-----|-------|-----------|
| **Rider App** | End customers who find, unlock, and ride scooters | Android, iOS |
| **Hub Operator App** | Staff at scooter hubs who manage fleet and scan QR codes | Android, iOS |
| **Admin Panel** | Business owners / managers — view KPIs, manage fleet and users | Web, Desktop |

### Backend API
A secure REST API + real-time GPS tracking server that powers all three apps.  
Handles: user authentication, vehicle tracking, ride billing, wallet payments, Razorpay integration.

### What is Included

- ✅ User registration and login (OTP via SMS)
- ✅ Map view showing nearby available scooters
- ✅ QR code scan to unlock a scooter
- ✅ Live ride tracking with fare meter
- ✅ Wallet top-up via Razorpay
- ✅ Ride history and receipts
- ✅ Hub operator fleet management
- ✅ Admin dashboard with KPIs and reports
- ✅ Multi-language support (English, Hindi, Tamil, Telugu, Kannada)
- ✅ White-label branding (your logo, colors, app name)
- ✅ Tablet and web responsive layouts

---

## 2. Source Code Repositories

| Repository | URL | Contents |
|-----------|-----|---------|
| Frontend | https://github.com/kusumeshkant/ev-platform-frontend | Flutter apps + packages |
| Backend | https://github.com/kusumeshkant/ev-platform-backend | API server + database |

### Branch Structure
- `main` — stable, production-ready code
- `develop` — active development (all new features go here first)

---

## 3. How Future Changes Work

### Making App Changes (e.g., new screen, UI change)

1. A developer creates a new branch from `develop`
2. Makes changes, submits a Pull Request to `develop`
3. Another developer reviews and approves
4. Code is merged and CI/CD tests run automatically
5. When ready for release, `develop` is merged into `main`
6. A new app build is generated and submitted to app stores

**Typical time for a small change:** 1–3 days  
**Typical time for a new feature:** 1–3 weeks depending on complexity

### Making Backend Changes (e.g., new API, pricing rule)

Same process as above but in the backend repository.  
Database changes require a "migration" — a script that safely updates the database structure.

### No-code changes (branding, text, colors)

Brand config (`brand.json`) and localization files (`.arb`) can be updated without rebuilding the whole app. Rebuild and resubmit is still required for app store distribution.

---

## 4. Third-Party Services Required

Before going live, the following accounts must be set up:

| Service | Purpose | Where to get |
|---------|---------|-------------|
| **Twilio** | Sending OTP SMS to users | twilio.com |
| **Razorpay** | Payment gateway for wallet top-ups | razorpay.com |
| **Google Maps** | Map display in rider app | console.cloud.google.com |
| **Google Play** | Android app distribution | play.google.com/console |
| **Apple Developer** | iOS app distribution | developer.apple.com |
| **Cloud/VPS** | Hosting the API server | AWS / DigitalOcean / Render |
| **PostgreSQL** | Database (managed cloud recommended) | AWS RDS / Supabase / Neon |

---

## 5. Going Live Checklist

- [ ] Twilio account set up, verified phone number
- [ ] Razorpay live keys obtained and set in backend `.env`
- [ ] Google Maps API key with billing enabled
- [ ] Server provisioned (min 2GB RAM recommended)
- [ ] Database hosted on managed service (auto-backups enabled)
- [ ] Domain and SSL certificate configured
- [ ] Brand assets (logo, colors) injected via CI/CD
- [ ] App submitted to Google Play Store
- [ ] App submitted to Apple App Store
- [ ] Admin panel deployed to web hosting

---

## 6. Support and Maintenance

### Who to contact for

| Issue | Contact |
|-------|---------|
| Bug in the app | Development team |
| Server downtime | DevOps / hosting provider |
| Payment issues | Razorpay support |
| SMS not received | Twilio support |
| App store rejection | Development team |

### Recommended Maintenance

- **Weekly:** Review server logs for errors
- **Monthly:** Apply security updates to server packages
- **Per release:** Test all key flows on staging before production

---

## 7. What is NOT Included (Future Phases)

The following can be added in future development phases:

- Push notifications (Firebase FCM)
- Subscription / monthly pass plans
- Driver/fleet IoT device integration
- Advanced analytics dashboard
- Multi-city / multi-hub routing
- Customer support chat

---

*This document is confidential and intended for the named client only.*

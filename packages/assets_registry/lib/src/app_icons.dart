abstract final class AppIcons {
  static const _base = 'packages/assets_registry/assets/icons';

  // Map pins
  static const scooterPin          = '$_base/scooter_pin.svg';
  static const scooterPinActive    = '$_base/scooter_pin_active.svg';
  static const scooterPinLowBattery = '$_base/scooter_pin_low_battery.svg';
  static const hubPin              = '$_base/hub_pin.svg';

  // Bottom navigation
  static const home          = '$_base/home.svg';
  static const wallet        = '$_base/wallet.svg';
  static const profile       = '$_base/profile.svg';
  static const notifications = '$_base/notification.svg';
  static const history       = '$_base/history.svg';

  // Ride actions
  static const qrScan    = '$_base/qr_scan.svg';
  static const rideStart = '$_base/ride_start.svg';
  static const rideEnd   = '$_base/ride_end.svg';

  // Battery (resolved by level)
  static String batteryIcon(int level) {
    if (level > 60) return '$_base/battery_full.svg';
    if (level > 30) return '$_base/battery_mid.svg';
    if (level > 10) return '$_base/battery_low.svg';
    return '$_base/battery_critical.svg';
  }

  // Misc
  static const support  = '$_base/support.svg';
  static const settings = '$_base/settings.svg';
  static const location = '$_base/location.svg';
}

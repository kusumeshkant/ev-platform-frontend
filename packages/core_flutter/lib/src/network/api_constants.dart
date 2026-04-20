abstract final class ApiConstants {
  static const String baseUrl   = String.fromEnvironment('API_BASE_URL', defaultValue: 'http://10.0.2.2:3000');
  static const String apiV1     = '/api/v1';
  static const Duration timeout = Duration(seconds: 30);

  // Auth
  static const auth         = '$apiV1/auth';
  static const sendOtp      = '$auth/send-otp';
  static const verifyOtp    = '$auth/verify-otp';
  static const refreshToken = '$auth/refresh';
  static const logout       = '$auth/logout';

  // Vehicles
  static const vehicles         = '$apiV1/vehicles';
  static const nearbyVehicles   = '$vehicles/nearby';

  // Rides
  static const rides       = '$apiV1/rides';
  static const activeRide  = '$rides/active';

  // Wallet
  static const wallet         = '$apiV1/wallet';
  static const walletTopup    = '$wallet/topup';
  static const transactions   = '$wallet/transactions';

  // Profile
  static const users   = '$apiV1/users';
  static const profile = '$users/me';

  // Hubs
  static const hubs        = '$apiV1/hubs';
  static const nearbyHubs  = '$hubs/nearby';
}

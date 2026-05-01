class ApiEnvironment{
  static const baseUrl = 'http://localhost:5000/';
  static const apiPrefix = 'api/';

  // End Points
  static const sendOtp = 'auth/send-otp';
  static const verifyOtp = 'auth/verify-otp';
  static const completeProfile = 'user/complete-profile';
  static const getAgenda = 'meals/daily-agenda';
  static const foodScan = 'food/scan';
}
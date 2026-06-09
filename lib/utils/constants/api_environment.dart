class ApiEnvironment{
  static const baseUrl = 'http://localhost:8000/';
  static const apiPrefix = 'api/';

  // End Points
  static const sendOtp = 'auth/send-otp';
  static const verifyOtp = 'auth/verify-otp';
  static const completeProfile = 'user/complete-profile';
  static const getAgenda = 'meals/daily-agenda';
  static const foodScan = 'food/scan';
  static const logMeal = 'meals/log';
  static const refreshToken = 'auth/refresh-token';
  static const logout = 'auth/logout';
  static const getHistory = 'meals/history';
  static const leaderboardProgress = 'leaderboard/progress';
  static const getNotification = 'notifications';
  static const updateGoal = 'user/goal';
  static const preferenceOptions = 'user/preference-options';
  static const suggestMeal = 'meals/suggested-meals';
}
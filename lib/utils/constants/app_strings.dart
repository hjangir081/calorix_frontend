import 'package:flutter/material.dart';

import '../../domain/models/IntroModel.dart';
import '../design/app_colors.dart';
import 'app_images.dart';

abstract class AppStrings {
  static const String login = 'Login';
  static const String verifyYourNumber = 'Verify Your Number';
  static const String sentCode = 'We’ve sent a 6-digit verification code to your mobile number. Enter the code below to continue.';
  static const String otpNotReceive = 'Didn’t receive the code?';
  static const String resentOtp = 'Resend OTP';
  static const String whatsGender = "What's your gender?";
  static const String whatsYourGoal = "What goal do you have in mind?";
  static const String weightQuestion = "How much do you weigh?";
  static const String heightQuestion = "What is your current height?";
  static const String averageAdherence = "Average Adherence";
  static const String dailyLogged = "Days Logged";
  static const String currentStreak = "Current Streak";
  static const String bestStreak = "Best Streak";
  static const String updateGoal = "Update Goal";
  static const String duration = "Duration";
  static const String viewFullPlan = "View Full Plan";
  static const String todayMealPlan = "Today's meal plan";
}

abstract class AppBtnStrings {
  static const String sendOtp = 'Send OTP';
  static const String verifyOtp = 'Verify OTP';
  static const String continueBtn = 'Continue';
  static const String skip = 'Skip';
  static const String back = 'Back';
  static const String getStarted = 'Get Started';
  static const String next = 'Next';
}

abstract class AppFieldsStrings {
  static const String enterFirstName = 'Enter first name';
  static const String enterLastName = 'Enter last name';
  static const String enterEmail = 'Enter email';
  static const String dateOfBirth = 'Select your date of birth';
  static const String firstNameField = 'First Name';
  static const String lastNameField = 'Last Name';
  static const String emailField = 'Email';
  static const String genderField = 'Gender';
  static const String dobField = 'Date of Birth';
}

abstract class GoalStrings {
  static const String loseWeight = 'Lose Weight';
  static const String maintainWeight = 'Maintain Weight';
  static const String gainWeight = 'Gain Weight';
  static const String lose = 'Lose';
  static const String gain = 'Gain';
  static const String maintain = 'Maintain';
  static const String currentGoal = 'Current Goal';
}

final introData = [
  IntroModel(
    image: AppImages.onBoardFruitBowl,
    titleParts: [
      IntroTitlePart("Track Your "),
      IntroTitlePart("Nutrition", color: AppColors.primaryColor),
      IntroTitlePart(", Improve Your "),
      IntroTitlePart("Health", color: Colors.green),
    ],
    subtitle: "Stay on track by logging every meal.",
  ),
];
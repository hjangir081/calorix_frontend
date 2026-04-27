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

abstract class GoalStrings {
  static const String loseWeight = 'Lose Weight';
  static const String maintainWeight = 'Maintain Weight';
  static const String gainWeight = 'Gain Weight';
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
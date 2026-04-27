import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final otpNotifierProvider =
NotifierProvider<OtpNotifier, String>(() => OtpNotifier());

class OtpNotifier extends Notifier<String> {
  static const int length = 4;

  late final List<TextEditingController> controllers;
  late final List<FocusNode> focusNodes;

  @override
  String build() {
    controllers = List.generate(length, (_) => TextEditingController());
    focusNodes = List.generate(length, (_) => FocusNode());

    ref.onDispose(() {
      for (final c in controllers) c.dispose();
      for (final f in focusNodes) f.dispose();
    });

    return '';
  }

  String get otp => controllers.map((e) => e.text).join();

  void _sync() => state = otp;

  void onChanged(int index, String value, Function(String)? onChanged, Function(String)? onCompleted) {
    // paste handling
    if (value.length >= length) {
      _handlePaste(value, onChanged, onCompleted);
      return;
    }

    // keep last digit only
    if (value.length > 1) {
      controllers[index].text = value.characters.last;
      controllers[index].selection =
      const TextSelection.collapsed(offset: 1);
    }

    _sync();
    onChanged?.call(otp);

    if (controllers[index].text.isNotEmpty) {
      if (index < length - 1) {
        focusNodes[index + 1].requestFocus();
      } else {
        focusNodes[index].unfocus();
        final isComplete = controllers.every((c) => c.text.isNotEmpty);
        if (isComplete) {
          onCompleted?.call(otp);
        }
      }
    }
  }

  void onBackspace(int index, KeyEvent event, Function(String)? onChanged) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        controllers[index].text.isEmpty &&
        index > 0) {
      focusNodes[index - 1].requestFocus();
      controllers[index - 1].clear();
      _sync();
      onChanged?.call(otp);
    }
  }

  void _handlePaste(String value, Function(String)? onChanged, Function(String)? onCompleted) {
    final digits = value.replaceAll(RegExp(r'\D'), '');

    for (int i = 0; i < length; i++) {
      controllers[i].text = i < digits.length ? digits[i] : '';
    }

    focusNodes.last.unfocus();
    _sync();

    onChanged?.call(otp);

    if (digits.length >= length) {
      onCompleted?.call(otp.substring(0, length));
    }
  }

  void clear() {
    for (final c in controllers) c.clear();
    focusNodes.first.requestFocus();
    _sync();
  }
}


final otpTimerProvider = StateNotifierProvider<OtpTimerNotifier, int>((ref) {
  return OtpTimerNotifier();
});
class OtpTimerNotifier extends StateNotifier<int> {
  OtpTimerNotifier() : super(30) {
    startTimer();
  }

  Timer? _timer;

  void startTimer() {
    state = 30;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state == 0) {
        timer.cancel();
      } else {
        state--;
      }
    });
  }

  void resend() {
    // 🔥 call resend API here if needed
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
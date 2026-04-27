import 'package:flutter/material.dart';

class AppSnackbar {
  static final GlobalKey<ScaffoldMessengerState> messengerKey =
  GlobalKey<ScaffoldMessengerState>();

  static void show({
    required String message,
    SnackbarType type = SnackbarType.info,
  }) {
    final color = _getColor(type);

    messengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(
          top: 20,
          left: 16,
          right: 16,
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static Color _getColor(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return Colors.green;
      case SnackbarType.error:
        return Colors.red;
      case SnackbarType.warning:
        return Colors.orange;
      case SnackbarType.info:
        return Colors.black;
    }
  }
}

enum SnackbarType { success, error, warning, info }

class AppTopSnackbar {
  static void show(
      BuildContext context,
      String message, {
        SnackbarType type = SnackbarType.info,
        Duration duration = const Duration(seconds: 3),
      }) {
    final overlay = Overlay.of(context);

    late OverlayEntry entry;
    bool isRemoved = false;

    void removeEntry() {
      if (!isRemoved) {
        isRemoved = true;
        entry.remove();
      }
    }

    entry = OverlayEntry(
      builder: (_) => _AnimatedSnackbar(
        message: message,
        type: type,
        duration: duration,
        onDismiss: removeEntry,
      ),
    );

    overlay.insert(entry);
  }
}

class _AnimatedSnackbar extends StatelessWidget {
  final String message;
  final SnackbarType type;
  final Duration duration;
  final VoidCallback onDismiss;

  const _AnimatedSnackbar({
    required this.message,
    required this.type,
    required this.duration,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {

    Future.delayed(duration, onDismiss);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: -120, end: 60),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Positioned(
          top: value,
          left: 16,
          right: 16,
          child: Opacity(
            opacity: value < 0 ? 0 : 1,
            child: child,
          ),
        );
      },
      child: _SnackbarContent(
        message: message,
        type: type,
      ),
    );
  }
}

class _SnackbarContent extends StatelessWidget {
  final String message;
  final SnackbarType type;

  const _SnackbarContent({
    required this.message,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(14),
      color: _getColor(type),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            /*Icon(
              _getIcon(type),
              color: Colors.white,
            ),*/
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Colors
  Color _getColor(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return Colors.green;
      case SnackbarType.error:
        return Colors.red;
      case SnackbarType.warning:
        return Colors.orange;
      case SnackbarType.info:
        return Colors.black87;
    }
  }

  /// Icons
  IconData _getIcon(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return Icons.check_circle;
      case SnackbarType.error:
        return Icons.error;
      case SnackbarType.warning:
        return Icons.warning;
      case SnackbarType.info:
        return Icons.info;
    }
  }
}
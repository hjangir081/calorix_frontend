import 'package:flutter/material.dart';

class LoaderOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const   LoaderOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white,),
              ),
            ),
          ),
      ],
    );
  }
}

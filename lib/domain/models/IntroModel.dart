import 'dart:ui';
class IntroTitlePart {
  final String text;
  final Color? color;

  IntroTitlePart(this.text, {this.color});
}

class IntroModel {
  final String image;
  final List<IntroTitlePart> titleParts;
  final String subtitle;

  IntroModel({
    required this.image,
    required this.titleParts,
    required this.subtitle,
  });
}
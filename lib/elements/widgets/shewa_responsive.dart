import 'package:flutter/material.dart';

class ShewaResponsive extends StatelessWidget {
  const ShewaResponsive({super.key, required this.mobile, required this.tablet});
  final Widget mobile;
  final Widget tablet;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 767) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}

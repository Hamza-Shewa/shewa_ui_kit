import 'package:flutter/material.dart';

class ShewaLoading extends StatelessWidget {
  const ShewaLoading({super.key, this.progress});
  final double? progress;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.surface,
      child: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
          strokeWidth: 4,
          value: progress,
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }
}

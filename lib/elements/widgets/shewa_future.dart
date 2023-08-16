
import 'package:flutter/material.dart';
import 'package:shewa_ui_kit/elements/widgets/shewa_container.dart';
import 'package:shewa_ui_kit/elements/widgets/shewa_loading.dart';

class ShewaFuture<T> extends StatelessWidget {
  const ShewaFuture({
    Key? key,
    required this.future,
    required this.view,
    this.size = 180,
  }) : super(key: key);
  final Future<T> future;
  final Widget Function(T?) view;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FutureBuilder<T>(
      future: future,
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return view.call(snapshot.data);
        }
        if (snapshot.hasError) {
          return ShewaContainer(
            height: size,
            child: Center(
              child: Text(
                'حدث خطأ يرجى المحاولة لاحقا',
                style: theme.textTheme.displayLarge,
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ShewaContainer(
            height: size,
            child: const ShewaLoading(),
          );
        }
        return ShewaContainer(
          height: size,
          child: Center(
            child: Text(
              'حدث خطأ ما',
              style: theme.textTheme.displayLarge,
            ),
          ),
        );
      },
    );
  }
}

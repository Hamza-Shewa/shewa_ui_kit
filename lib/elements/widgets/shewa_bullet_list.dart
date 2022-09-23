import 'package:flutter/material.dart';

class ShewaBulletList extends StatelessWidget {
  const ShewaBulletList(this.texts, {Key? key}) : super(key: key);
  final List<String> texts;

  @override
  Widget build(BuildContext context) {
    var widgetList = <Widget>[];
    for (var text in texts) {
      widgetList.add(ShewaBulletListItem(text));
      widgetList.add(const SizedBox(height: 5.0));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: widgetList,
      ),
    );
  }
}

class ShewaBulletListItem extends StatelessWidget {
  const ShewaBulletListItem(this.text, {Key? key}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 450,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "\u2022 ",
            style: theme.textTheme.bodyText1!.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              text,
              style:  theme.textTheme.bodyText1!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

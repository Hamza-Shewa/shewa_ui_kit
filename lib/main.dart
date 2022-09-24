import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shewa_ui_kit/drawer/elements/shewa_drawer.dart';
import 'package:shewa_ui_kit/drawer/elements/shewa_drawer_button.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      path: 'assets/translations',
      startLocale: const Locale('ar'),
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'application',
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      theme: ThemeData(
        backgroundColor: Colors.white,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      endDrawer: ShewaDrawer(
        locale: context.locale,
        endDrawer: true,
        circleAvatar: const CircleAvatar(
          radius: 36,
          child: Text('hamza'),
        ),
        leading: ListTile(
          title: Text('hamza bashir'),
          subtitle: Text('administrator'),
        ),
        icon: AnimatedIcons.menu_close,
        buttons: [
          ShewaDrawerButton(
            color: Colors.white,
            icon: const Icon(Icons.home),
            title: const Text('الرئيسية'),
            onPressed: () {},
          ),
          ShewaDrawerButton(
            color: Colors.white,
            icon: const Icon(Icons.search),
            //title: const Text('البحث'),
            onPressed: () {},
          ),
          ShewaDrawerButton(
            color: Colors.white,
            icon: const Icon(Icons.receipt),
            title: const Text('فواتير'),
            onPressed: () {},
          ),
          ShewaDrawerButton(
            color: Colors.white,
            icon: const Icon(Icons.add),
            title: const Text('اضافة'),
            onPressed: () {},
          ),
        ],
        endButton: ShewaDrawerButton(
          color: Colors.white,
          icon: const Icon(Icons.logout),
          title: const Text('تسجيل خروج'),
          onPressed: () {},
        ),
      ),
      body: const Text('test'),
    );
  }
}

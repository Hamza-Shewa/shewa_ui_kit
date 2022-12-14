import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shewa_ui_kit/drawer/elements/shewa_drawer.dart';
import 'package:shewa_ui_kit/drawer/elements/shewa_drawer_button.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const Directionality(
      textDirection: TextDirection.rtl,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'application',
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
      drawer: ShewaDrawer(
        textDirection: TextDirection.rtl,
        endDrawer: true,
        circleAvatar: const CircleAvatar(
          radius: 36,
          child: Text('hamza'),
        ),
        leading: const ListTile(
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

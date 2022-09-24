import 'package:flutter/material.dart';
import 'package:shewa_ui_kit/drawer/elements/shewa_drawer.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'application',
      home: Home(),
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
      // drawer: ShewaDrawer(icon: AnimatedIconData(
      //
      // ), buttons: []),
      body:  const Text('test'),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shewa_ui_kit/drawer/elements/shewa_drawer.dart';
import 'package:shewa_ui_kit/drawer/elements/shewa_drawer_button.dart';
import 'package:shewa_ui_kit/elements/widgets/countriesPicker/shewa_country_picker.dart';
import 'package:shewa_ui_kit/elements/widgets/storeDropdownButton/components/shewa_dropdown_controller.dart';
import 'package:shewa_ui_kit/elements/widgets/storeDropdownButton/components/shewa_dropdown_item.dart';
import 'package:shewa_ui_kit/elements/widgets/storeDropdownButton/shewa_dropdown_button.dart';
import 'package:shewa_ui_kit/shewa_ui_kit.dart';

import 'elements/widgets/countriesPicker/countries.dart';

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
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
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
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 150,
              child: ShewaCountryPicker(
                shewaDropDownStyle: ShewaDropDownStyle(
                  prefix: true,
                ),
                onTap: (coountry) {
                  print(coountry);
                },
              ),
            ),
            ShewaButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      body: Column(
                        children: [
                          ShewaButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            text: 'go back',
                          ),
                          ShewaCountryPicker(
                            onTap: (coountry) {
                              print(coountry);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              text: 'go to second page',
            ),
          ],
        ),
      ),
    );
  }
}

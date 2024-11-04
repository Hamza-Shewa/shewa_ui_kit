import 'package:flutter/material.dart';
import 'package:shewa_ui_kit/shewa_ui_kit.dart';

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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'application',
      theme: ThemeData(),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

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
          iconData: AnimatedIcons.menu_close,
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
              title: const Text('Jautājumi un atbildes'),
              titleFlex: 2,
              iconFlex: 0,
              iconMargin: const EdgeInsetsDirectional.only(end: 10),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShewaCountryPicker(
              enabled: false,
              shewaDropDownStyle: CountryDropDownStyle(
                prefix: true,
                dropDownFieldHint: 'اختر الدولة',
              ),
              initialValue: 'libya',
              onTap: (coountry) {
                print(coountry);
              },
            ),
            ShewaButton(
              duration: const Duration(milliseconds: 200),
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 20),
              onPressed: () {},
              color: Colors.red,
              hoverColor: Colors.red,
              leading: Container(
                margin: const EdgeInsetsDirectional.only(end: 5),
                child: const Icon(
                  Icons.social_distance_outlined,
                  color: Colors.white,
                ),
              ),
              text: "Google",
              textStyle: const TextStyle(
                color: Colors.white,
              ),
            ),
            ShewaOutLinedButton(
              duration: const Duration(seconds: 3),
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 20),
              onPressed: () {},
              color: Colors.red,
              hoverColor: Colors.red,
              leading: Container(
                margin: const EdgeInsetsDirectional.only(end: 5),
                child: const Icon(
                  Icons.social_distance_outlined,
                  color: Colors.white,
                ),
              ),
              text: "Google",
              textStyle: const TextStyle(
                color: Colors.white,
              ),
            ),
            ShewaButton(
              textOnly: false,
              width: double.infinity,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      body: Column(
                        children: [
                          ShewaButton(
                            width: 100,
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

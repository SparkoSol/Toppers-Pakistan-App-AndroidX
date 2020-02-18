import 'package:flutter/material.dart';
import 'package:topperspakistan/pages/splash.dart';

import 'models/local-data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalData.initPath();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xffbc282b),
        accentColor: Color(0xffCE862A),
      ),
      home: Splash(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:topperspakistan/cart_list.dart';
import 'package:topperspakistan/pages/splash.dart';

import 'models/local-data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalData.initPath();
  await CartList.readCartData();
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
        appBarTheme: AppBarTheme(
          textTheme: GoogleFonts.googleSansTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        textTheme: GoogleFonts.googleSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: Splash(),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:topperspakistan/cart_list.dart';
import 'package:topperspakistan/pages/homepage.dart';
import 'package:topperspakistan/pages/privacy-policy.dart';
import 'package:topperspakistan/pages/splash.dart';
import 'package:topperspakistan/rate.dart';

import 'models/local-data.dart';
import 'utils/connectivityService.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();
  await LocalData.initPath();
  await CartList.readCartData();
  Rate.initState();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityStatus>(
      create: (context) =>
          ConnectivityService().connectionStatusController.stream,
      child: MaterialApp(
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
        home: HomePage(),
        // home: PrivacyPolicy(),
      ),
    );
  }
}

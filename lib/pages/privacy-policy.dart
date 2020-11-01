import 'dart:async';

import 'package:flutter/material.dart';
import 'package:topperspakistan/pages/loading.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();
  var _url;
  final _key = UniqueKey();
  num _stackToView = 1;

  void _handleLoad(String value) {
    setState(() {
      _stackToView = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Privacy Policy",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: <Widget>[
            new IconButton(
              icon: new Image.asset('images/LogoTrans.png'),
              iconSize: 80.0,
              onPressed: null,
            ),
          ],
        ),
        body: IndexedStack(
          index: _stackToView,
          children: [
            Column(
              children: <Widget>[
                Expanded(
                    child: WebView(
                  key: _key,
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: "http://toppers-pakistan.toppers-mart.com/privacy-policy",
                  onPageFinished: _handleLoad,
                )),
              ],
            ),
            Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        )
        //  WebView(
        //   // initialUrl: "https://www.toppers-pakistan.toppers-mart.com",
        //   initialUrl: "https://www.facebook.com",
        //   // initialUrl: "https://www.firebasestorage.googleapis.com/v0/b/toppers-pakistan.appspot.com/o/privacy-policy%2Fprivacy_policy.html?alt=media&token=dc73770f-a604-46af-9576-1093add2d7db",
        //   onWebViewCreated: (WebViewController webViewController){
        //     _completer.complete(webViewController);
        //   },
        // ),
        );
  }
}

import 'package:rate_my_app/rate_my_app.dart';

class Rate {
  static RateMyApp _rateMyApp = RateMyApp(
  );


  static RateMyApp getRate(){
    return _rateMyApp;
  }

  static void initState() {
    _rateMyApp.init().then((_) {
      _rateMyApp.conditions.forEach((condition) {
        if (condition is DebuggableCondition) {
          print(condition
              .valuesAsString()); // We iterate through our list of conditions and we print all debuggable ones.
        }
      });

      print('Are all conditions met ? ' +
          (_rateMyApp.shouldOpenDialog ? 'Yes' : 'No'));
    });
  }
}
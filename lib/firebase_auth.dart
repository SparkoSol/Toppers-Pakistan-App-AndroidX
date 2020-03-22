import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthentication {
  static facebookAuth(void Function(FirebaseUser) onComplete) async {
    print("fb1 ");
    final facebookLogin = new FacebookLogin();
    print("fb2 ");
    final FacebookLoginResult result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        FacebookAccessToken accessToken = result.accessToken;
        AuthCredential credential =
            FacebookAuthProvider.getCredential(accessToken: accessToken.token);
        try {
          print("1");
          var hd = await FirebaseAuth.instance.signInWithCredential(credential);
          print('2=>'+ hd.toString());
          FirebaseUser user = (hd).user;
          onComplete(user);
        } catch (e) {
          onComplete(null);
          print("error=>" + e.toString());
          break;
        }
        print("Fb logged in");  
        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        onComplete(null);
        print(result.errorMessage);
        break;
    }

  }

  static googleAuth(void Function(FirebaseUser) onComplete) async {
    final authentication = await (await GoogleSignIn().signIn()).authentication;
    final credential = GoogleAuthProvider.getCredential(
      idToken: authentication.idToken,
      accessToken: authentication.accessToken,
    );
    onComplete(
        (await FirebaseAuth.instance.signInWithCredential(credential)).user);
  }

  static googleDestroy() async {
    await GoogleSignIn().disconnect();
    await GoogleSignIn().signOut();
  }
}

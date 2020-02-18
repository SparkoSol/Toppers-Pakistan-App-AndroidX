import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthentication {
  static facebookAuth(void Function(FirebaseUser) onComplete) async {
    final facebookLogin = FacebookLogin();

    final authResult = await facebookLogin.logIn(["email", "public_profile"]);

    switch (authResult.status) {
      case FacebookLoginStatus.loggedIn:
        onComplete((await FirebaseAuth.instance.signInWithCredential(
                FacebookAuthProvider.getCredential(
                    accessToken: authResult.accessToken.token)))
            .user);
        print("Fb logged in");

        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        onComplete(null);
        print("FB login error");
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
}

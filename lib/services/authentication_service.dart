import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  // create a signup method with firebase
  signup({String email, String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e.message);
      throw FirebaseAuthException(code: '', message: e.message);
    }
  }

  // create a logout method with firebase
  logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e.message);
      throw FirebaseAuthException(code: '', message: e.message);
    }
  }

  // create a login method with firebase
  login({String email, String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
      throw FirebaseAuthException(code: '', message: e.toString());
    }
  }
}

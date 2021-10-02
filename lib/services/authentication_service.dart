import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:kingfisher/models/kingfisher_user.dart';
import 'package:kingfisher/notifiers/user_notifier.dart';
import 'package:kingfisher/services/locator.dart';
import 'package:kingfisher/services/profile_service.dart';

class AuthenticationService {
  ValueNotifier<KingfisherUser> _user = getIt<UserNotifier>().user;
  // create a signup method with firebase
  signup({String email, String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        _user.value.email = email;
        _user.value.id = value.user.uid;
      });
    } catch (e) {
      print(e.message);
      throw FirebaseAuthException(code: '', message: e.message);
    }
  }

  // create a logout method with firebase
  logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      _user.value = null;
    } catch (e) {
      print(e.message);
      throw FirebaseAuthException(code: '', message: e.message);
    }
  }

  // create a login method with firebase
  login({String email, String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        final _profileService = getIt<ProfileService>();
        await _profileService.setProfile();
      });
    } catch (e) {
      print(e);
      throw FirebaseAuthException(code: '', message: e.toString());
    }
  }
}

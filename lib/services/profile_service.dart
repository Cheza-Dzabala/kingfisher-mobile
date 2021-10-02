import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kingfisher/models/kingfisher_user.dart';
import 'package:kingfisher/notifiers/user_notifier.dart';

import 'locator.dart';

class ProfileService {
  ValueNotifier<KingfisherUser> _user = getIt<UserNotifier>().user;
  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('users');

  createProfile() async {
    try {
      await _collectionReference.doc(_user.value.id).set(_user.value.toJson());
    } catch (e) {
      print(e);
      throw new Exception(e.toString());
    }
  }

  // Get Profile and return an instance of KingfisherUser
  setProfile() async {
    try {
      var userData = await _collectionReference
          .doc(FirebaseAuth.instance.currentUser.uid)
          .get();
      _user.value = KingfisherUser.fromJson(userData.data());
    } catch (e) {
      print(e);
      throw new Exception(e.toString());
    }
  }
}

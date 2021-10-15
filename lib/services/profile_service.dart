import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kingfisher/models/kingfisher_user.dart';
import 'package:kingfisher/providers/user_provider.dart';

class ProfileService {
  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('users');

  createProfile({@required KingfisherUser user}) async {
    user.id = FirebaseAuth.instance.currentUser.uid;
    user.createdAt = Timestamp.now();
    try {
      await _collectionReference.doc(user.id).set(user.toJson());
    } catch (e) {
      print(e);
      throw new Exception(e.toString());
    }
  }

  // Get Profile and return an instance of KingfisherUser
  Future<KingfisherUser> getProfile() async {
    try {
      var userData = await _collectionReference
          .doc(FirebaseAuth.instance.currentUser.uid)
          .get();
      return KingfisherUser.fromJson(userData.data());
    } catch (e) {
      print(e);
      throw new Exception(e.toString());
    }
  }

  // Upload avatar
  Future<String> uploadAvatar({@required File file}) async {
    final user = FirebaseAuth.instance.currentUser.uid;
    String storagePath = 'avatars/$user/';
    String filename = FirebaseStorage.instance.ref().child(storagePath).name;
    var storageReference =
        FirebaseStorage.instance.ref().child(storagePath).child(filename);

    try {
      var task = await storageReference.putFile(file);
      var downloadUrl = await task.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('File upload error $e');
      throw new Exception('Failed to upload file');
    }
  }
}

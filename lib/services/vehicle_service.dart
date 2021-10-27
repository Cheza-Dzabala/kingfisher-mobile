import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:kingfisher/models/vehicle.dart';
import 'package:uuid/uuid.dart';

class VehicleService {
  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('vehicles');
  // Save vehicle to firebase
  save({@required Vehicle vehicle}) async {
    try {
      await _collectionReference.add(vehicle.toJson());
    } catch (e) {
      print(e.toString());
      throw Exception('Unable to add vehicle to database');
    }
  }

  // Upload vehicle image to firebase storage
  uploadVehicleImage({@required File image}) async {
    String userId = FirebaseAuth.instance.currentUser.uid;
    String storagePath = '/vehicles/$userId';
    String id = Uuid().v4();

    var storageReference =
        FirebaseStorage.instance.ref().child(storagePath).child(id);

    try {
      var task = await storageReference.putFile(image);
      var downloadUrl = await task.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('File upload error $e');
      throw new Exception('Failed to upload file');
    }
  }

  // Remove image from firebase storage
  deleteVehicleImage({@required String imageUrl}) async {
    try {
      Reference ref = FirebaseStorage.instance.refFromURL(imageUrl);
      await ref.delete();
    } catch (e) {
      print('File delete error $e');
      throw new Exception('Failed to delete file');
    }
  }

  Stream<List<Vehicle>> getAll() {
    return _collectionReference
        .where('user_id', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((document) {
            print(document.data());
            return Vehicle.fromJson(document.data());
          }).toList(),
        );
  }
}

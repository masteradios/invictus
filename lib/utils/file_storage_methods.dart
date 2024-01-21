import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
class FileStorage
{
  final FirebaseStorage _storage=FirebaseStorage.instance;
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  Future<String> uploadVideo(String videoPath,String id) async
  {
    Reference _ref=_storage.ref().child("videos").child(_auth.currentUser!.uid).child('$id.mp4');
    await _ref.putFile(File(videoPath));
    String downloadUrl=await _ref.getDownloadURL();
    return downloadUrl;
  }
}
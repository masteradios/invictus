import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:invictus/models/video.dart';
import 'package:invictus/utils/file_storage_methods.dart';
import 'package:invictus/widgets/show_snackbar.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> uploadVideodetails(
      {required BuildContext context,
      required String videoThumbnail,
      required String videoTitle,
      required String videoPath,
      required String standard,
      required String videoDescription,
      required String language}) async {
    String id = Uuid().v4();
    String userid = _auth.currentUser!.uid;
    String videoUrl = await FileStorage().uploadVideo(videoPath, id);
    Video _video = Video(
        videoUrl: videoUrl,
        videoThumbnail: "https://cdn-icons-png.flaticon.com/512/10151/10151694.png",
        videoTitle: videoTitle,
        videoDescription: videoDescription,
        standard: standard,
        id: id,
        userid: userid,
        language: language);
    try {
      await _firestore.collection('videos').doc(id).set(_video.toMap());
      showSnackBar(context: context, content: 'Video uploaded Successfully');
    } catch (err) {
      showSnackBar(context: context, content: err.toString());
    }
  }

  Future<List<Video>> getCommunityVideos(
      {required BuildContext context}) async {
    List<Video> videos = [];
    try {
      QuerySnapshot snap = await _firestore
          .collection('videos')
          .where("userid", isEqualTo: _auth.currentUser!.uid)
          .get();
      for (int i = 0; i < snap.docs.length; i++) {
        videos.add(Video.fromSnap(snap.docs[i]));
      }
    } catch (err) {
      showSnackBar(context: context, content: err.toString());
    }
    return videos;
  }
}

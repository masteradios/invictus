import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  final String videoUrl;
  final String videoThumbnail;
  final String videoTitle;
  final String videoDescription;
  final String standard;
  final String userid;
  final String id;
  final String language;

  Video(
      {required this.videoUrl,
      required this.videoThumbnail,
      required this.videoTitle,
      required this.videoDescription,
      required this.standard,
      required this.id,
      required this.userid,
      required this.language});

  Map<String, dynamic> toMap() {
    return {
      'userid': userid,
      'videoUrl': videoUrl,
      'videoThumbnail': videoThumbnail,
      'videoDescription': videoDescription,
      'videoTitle': videoTitle,
      "standard": standard,
      "id": id,
      "language": language,
    };
  }

  factory Video.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Video(
        userid: snapshot['userid'],
        videoUrl: snapshot['videoUrl'],
        videoThumbnail: snapshot['videoThumbnail'],
        videoDescription: snapshot['videoDescription'],
        videoTitle: snapshot['videoTitle'],
        standard: snapshot['standard'],
        id: snapshot['id'],
        language: snapshot['language']);
  }
}

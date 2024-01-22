import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:invictus/models/youtube_video.dart';
import 'package:invictus/widgets/show_snackbar.dart';

import '../constants.dart';
import 'http_error_handle.dart';

class YoutubeRec {
  Future<List<Youtube>> getYoutubeRec({required BuildContext context,required String query,required String channelId}) async {
    List<Youtube> ytvideos = [];
    try {
      http.Response res = await http.post(
        Uri.parse('https://7219-103-117-185-144.ngrok-free.app/videos'),
        body: jsonEncode({
          'query': query,
          "channelId": channelId
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
          res: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              Youtube v = Youtube.fromMap(jsonDecode(res.body)[i]);
              ytvideos.add(v);
            }
          });
    } catch (err) {
      showSnackBar(context: context, content: err.toString());
    }
    return ytvideos;
  }
}

import 'package:flutter/material.dart';
import 'package:invictus/utils/get_youtube_reccomendations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../../constants.dart';
import '../../models/video.dart';
import '../../models/youtube_video.dart';

class Sample extends StatefulWidget {
  static const routeName = '/sample';
  final Video video;
  Sample({required this.video});

  @override
  State<Sample> createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  bool isLoading = false;
  VideoPlayerController? _videocontroller;
  List<Youtube> videos = [];


  void playVideo() {
    _videocontroller = VideoPlayerController.networkUrl(Uri.parse(widget.video.videoUrl))
      ..initialize().then((_) {
        setState(() {});
        _videocontroller!.play();
      });
  }

  Widget _videoPreview() {
    return AspectRatio(
      aspectRatio: _videocontroller!.value.aspectRatio,
      child: VideoPlayer(_videocontroller!),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playVideo();
  }
  void redirectToURL(String urlString) async {
    var url = Uri.parse(urlString);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videocontroller!.dispose();}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: whiteColor,
          ),
        ),
        backgroundColor: greenColor,
        centerTitle: true,
        title: Text(
          'Suggested Youtube Videos',
          style: TextStyle(color: whiteColor),
        ),
      ),
      body: _videoPreview(),
    );
  }
}

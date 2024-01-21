import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../models/video.dart';
import '../models/youtube_video.dart';
import '../utils/get_youtube_reccomendations.dart';

class YoutubeScreen extends StatefulWidget {
  static const routeName = '/youtube-screen';
  final String query;
  final String channelId;
  YoutubeScreen({required this.query, required this.channelId});
  @override
  State<YoutubeScreen> createState() => _YoutubeScreenState();
}

class _YoutubeScreenState extends State<YoutubeScreen> {
  bool isLoading = false;
  List<Youtube> videos = [];

  Future<void> getVideos() async {
    setState(() {
      isLoading = true;
    });
    videos = await YoutubeRec().getYoutubeRec(
        context: context,
        query: '${widget.query} 12th standard',
        channelId: widget.channelId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVideos();
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
      body: (isLoading)
          ? Container(
              height: 200,
              child: Center(
                child: const CircularProgressIndicator(
                  color: greenColor,
                ),
              ),
            )
          : Container(
              width: double.infinity,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      redirectToURL(videos[index].videoUrl);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        border: Border.all(
                          color: Colors.grey, // Set the color of the border
                          width: 2.0, // Set the width of the border
                        ),
                        // Set the border radius
                      ),
                      margin: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Image.network(
                            videos[index].videoThumbnail,
                            fit: BoxFit.fitWidth,
                            height: 200,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              videos[index].videoTitle,
                              style: TextStyle(fontWeight: FontWeight.bold,color: whiteColor,fontSize: 15),
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: videos.length,
              )),
    );
  }
}

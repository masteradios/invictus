import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:invictus/screens/home/sample.dart';
import 'package:invictus/utils/firestore_methods.dart';

import '../constants.dart';
import '../models/video.dart';

class SlidingImage extends StatefulWidget {
  const SlidingImage({
    super.key,
  });

  @override
  State<SlidingImage> createState() => _SlidingImageState();
}

class _SlidingImageState extends State<SlidingImage> {
  List<Video> videos = [];
  List<String> images = [];
  bool isLoading = false;
  Future<void> getVideos() async {
    setState(() {
      isLoading = true;
    });
    videos = await FirestoreMethods().getCommunityVideos(context: context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getVideos();
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading)
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
            child: FutureBuilder(
                future: getVideos(),
                builder: (context, snapshot) {
                  return CarouselSlider(
                    items: videos.map((i) {
                      return GestureDetector(
                        onTap: ()
                        {
                          Navigator.pushNamed(context, Sample.routeName,arguments: i);
                        },
                        child: Image.network(
                          i.videoThumbnail,
                          fit: BoxFit.cover,
                          height: 200,
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      viewportFraction: 1,
                      height: 200,
                      autoPlay: true,
                    ),
                  );
                }));
  }
}

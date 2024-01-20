import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:invictus/constants.dart';
import 'package:invictus/utils/firestore_methods.dart';
import 'package:invictus/widgets/custom_button.dart';
import 'package:invictus/widgets/pick_video.dart';
import 'package:video_player/video_player.dart';

import '../../widgets/custom_textfield.dart';
import '../../widgets/show_snackbar.dart';

class UploadVideo extends StatefulWidget {
  const UploadVideo({super.key});
  static const routeName = '/add-product-screen';
  @override
  State<UploadVideo> createState() => _UploadVideoState();
}

class _UploadVideoState extends State<UploadVideo> {
  String? videoPath;
  String res = 'error';
  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _productnamecontroller.dispose();
    _productdescriptioncontroller.dispose();
    _videocontroller.dispose();
    _standardcontroller.dispose();
    _languagecontroller.dispose();
  }

  VideoPlayerController _videocontroller = VideoPlayerController.file(File(''));
  final _addProductkey = GlobalKey<FormState>();
  final TextEditingController _productnamecontroller = TextEditingController();
  final TextEditingController _standardcontroller = TextEditingController();
  final TextEditingController _productdescriptioncontroller =
      TextEditingController();
  final TextEditingController _languagecontroller = TextEditingController();

  void _selectvideo() async {
    videoPath = await pickVideo(context: context);
    setState(() {});
    playVideo();
  }

  void playVideo() {
    _videocontroller = VideoPlayerController.file(File(videoPath!))
      ..initialize().then((_) {
        setState(() {});
        _videocontroller.play();
      });
  }

  Widget _videoPreview() {
    return AspectRatio(
      aspectRatio: _videocontroller.value.aspectRatio,
      child: VideoPlayer(_videocontroller),
    );
    }

  void uploadVideo() async {
    await FirestoreMethods().uploadVideodetails(
        context: context,
        videoThumbnail: '',
        videoTitle: _productnamecontroller.text.trim(),
        videoPath: videoPath!,
        standard: _standardcontroller.text.trim(),
        videoDescription: _productdescriptioncontroller.text.trim(),
        language: _languagecontroller.text.trim() );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios)),
          title: Text('Upload a video'),
          flexibleSpace: Container(
            decoration: BoxDecoration(color: greenColor),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              videoPath == null
                  ? GestureDetector(
                      onTap: () {
                        _selectvideo();
                      },
                      child: Center(
                        child: DottedBorder(
                            dashPattern: [6, 3, 6, 3],
                            borderPadding: EdgeInsets.all(10),
                            borderType: BorderType.RRect,
                            radius: Radius.circular(15),
                            child: Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height / 4,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.video_library_outlined),
                                    Text(
                                      'Select Video',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                              ),
                            )),
                      ),
                    )
                  : Center(
                      child: _videoPreview(),
                    ),
              Form(
                key: _addProductkey,
                child: Column(
                  children: [
                    CustomTextFormField(
                        controller: _productnamecontroller,
                        hintText: 'Video Title',
                        keyboardType: TextInputType.text),
                    CustomTextFormField(
                      controller: _productdescriptioncontroller,
                      hintText: 'Video Description',
                      keyboardType: TextInputType.text,
                    ),
                    CustomTextFormField(
                      controller: _standardcontroller,
                      hintText: 'Standard',
                      keyboardType: TextInputType.text,
                    ),
                    CustomTextFormField(
                      controller: _languagecontroller,
                      hintText: 'Language of instruction used',
                      keyboardType: TextInputType.text,
                    ),
                  ],
                ),
              ),
              (isLoading)
                  ? Container(
                      width: double.infinity,
                      height: 40,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.zero,
                      ),
                      child: Center(
                        child: const CircularProgressIndicator(
                          color: backgroundColor,
                        ),
                      ),
                    )
                  : CustomButton(
                      buttontitle: 'Upload',
                      callback: () {
                        if (_addProductkey.currentState!.validate()) {
                          if (videoPath == null) {
                            showSnackBar(
                                context: context, content: 'Add video!!');
                          } else {
                            uploadVideo();
                            print('Add Successful!');
                          }
                        }
                      }),
            ],
          ),
        ),
      ),
    );
  }
}

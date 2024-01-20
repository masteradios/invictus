import 'package:flutter/material.dart';
import 'package:invictus/screens/drawer_screens/upload_video.dart';
import 'package:invictus/screens/recommend_exams/recomend_exams.dart';
import 'package:invictus/screens/youtube_recc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../screens/account_screen.dart';
import '../screens/govt_schemes/GovScheme_Recommend.dart';

showDrawer({required BuildContext context}) {
  void goToaccount() {
    Navigator.of(context).pop();
    Navigator.pushNamed(context, MyAccount.routeName);
  }

  void goToMySchemes() {
    Navigator.of(context).pop();
    Navigator.pushNamed(context, GovScheme_Recommend.routeName);
  }

  void goToExams() {
    Navigator.of(context).pop();
    Navigator.pushNamed(context, ExamRecommend.routeName);
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

  void goToCommunity() {
    Navigator.of(context).pop();
    Navigator.pushNamed(context, UploadVideo.routeName);
  }

  return SafeArea(
    child: ScaffoldMessenger(
        child: Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            CircleAvatar(
              child: Icon(
                Icons.person_outline_outlined,
                size: 60,
              ),
              radius: 60,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Column(
                  children: [
                    DrawerChild(
                      title: 'My Account',
                      callback: () => goToaccount(),
                      iconimage: 'assets/user.png',
                    ),
                    DrawerChild(
                      title: 'Schemes',
                      callback: () => goToMySchemes(),
                      iconimage: 'assets/scheme.png',
                    ),
                    DrawerChild(
                      title: 'Exams',
                      callback: () => goToExams(),
                      iconimage: 'assets/exam.png',
                    ),
                    DrawerChild(
                      title: 'Contribute to Community',
                      callback: () => goToCommunity(),
                      iconimage: 'assets/community.png',
                    ),
                    DrawerChild(
                      title: 'Get NCERT',
                      callback: () =>
                          redirectToURL('https://ncert.nic.in/textbook.php'),
                      iconimage: 'assets/open-book.png',
                    ),
                    DrawerChild(
                      title: 'Get Ebalbharti',
                      callback: () =>
                          redirectToURL('https://books.ebalbharati.in/'),
                      iconimage: 'assets/open-book.png',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: whiteColor,
    )),
  );
}

class DrawerChild extends StatelessWidget {
  const DrawerChild(
      {super.key,
      required this.title,
      required this.callback,
      required this.iconimage});
  final String title;
  final String iconimage;
  final VoidCallback callback;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: GestureDetector(
        onTap: callback,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 30,
              height: 30,
              child: Image.asset(
                iconimage,
                width: 512,
                height: 512,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
            )
          ],
        ),
      ),
    );
  }
}

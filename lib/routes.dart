import 'package:flutter/material.dart';
import 'package:invictus/screens/Doubt_Solver/DoubtSolver.dart';
import 'package:invictus/screens/account_screen.dart';
import 'package:invictus/screens/auth/auth_screen.dart';
import 'package:invictus/screens/auth/login_screen.dart';
import 'package:invictus/screens/chat/chat_screen.dart';
import 'package:invictus/screens/drawer_screens/upload_video.dart';
import 'package:invictus/screens/get_info/get_user_detail_page.dart';
import 'package:invictus/screens/govt_schemes/GovScheme_Recommend.dart';
import 'package:invictus/screens/home/home_screen.dart';
import 'package:invictus/screens/home/sample.dart';
import 'package:invictus/screens/recommend_exams/recomend_exams.dart';
import 'package:invictus/screens/youtube_recc.dart';

import 'models/video.dart';

Route getRoutes(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(builder: (context) {
        return const AuthScreen();
      });
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (context) {
        return const HomeScreen();
      });
    case UploadVideo.routeName:
      return MaterialPageRoute(builder: (context) {
        return const UploadVideo();
      });
    case DoubtSolver.routeName:
      return MaterialPageRoute(builder: (context) {
        return const DoubtSolver();
      });
    case Sample.routeName:
      return MaterialPageRoute(builder: (context) {
        var video = routeSettings.arguments as Video;
        return Sample(
          video: video,
        );
      });
    case ChatScreen.routeName:
      return MaterialPageRoute(builder: (context) {
        return ChatScreen();
      });
    case YoutubeScreen.routeName:
      return MaterialPageRoute(builder: (context) {
        var query = routeSettings.arguments as String;
        var channelId = routeSettings.arguments as String;
        return YoutubeScreen(
          query: query,
          channelId: channelId,
        );
      });
    case GetUserDetails.routeName:
      return MaterialPageRoute(builder: (context) {
        return GetUserDetails();
      });
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) {
        return LoginScreen();
      });
    case ExamRecommend.routeName:
      return MaterialPageRoute(builder: (context) {
        return ExamRecommend();
      });
    case GovScheme_Recommend.routeName:
      return MaterialPageRoute(builder: (context) {
        return GovScheme_Recommend();
      });
    case MyAccount.routeName:
      return MaterialPageRoute(builder: (context) {
        return MyAccount();
      });
    default:
      return MaterialPageRoute(builder: (context) {
        return const Scaffold(
          body: Center(
            child: Text('Route don\'t exist'),
          ),
        );
      });
  }
}

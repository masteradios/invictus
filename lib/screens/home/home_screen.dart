import 'package:flutter/material.dart';
import 'package:invictus/constants.dart';
import 'package:invictus/models/user.dart';
import 'package:invictus/providers/user_provider.dart';
import 'package:invictus/screens/auth/services/auth_services.dart';
import 'package:invictus/screens/chat/chat_screen.dart';
import 'package:invictus/screens/youtube_recc.dart';
import 'package:invictus/widgets/show_drawer.dart';
import 'package:invictus/widgets/sliding_image.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }
  void getUser()async
  {
    await AuthServices().getUserDetails(context: context);
  }
  @override
  Widget build(BuildContext context) {
    ModelUser _user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: _buildAppbar(context: context),
      drawer: showDrawer(context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Community Posts',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SlidingImage(),
              Column(
                children: [
                  CurvedSquare(
                    title: 'Mathematics',
                    channelId: 'UCpyc1eTpM1cA3P0ZWym4clw',
                  ),
                  CurvedSquare(
                    title: 'Physics',
                    channelId: 'UCiGyWN6DEbnj2alu7iapuKQ',
                  ),
                  CurvedSquare(
                    title: 'Chemistry',
                    channelId: 'UCiGyWN6DEbnj2alu7iapuKQ',
                  ),
                  CurvedSquare(
                    title: 'Biology',
                    channelId: 'UC-WHWhLDdRAiiT53kqDe3PA',
                  ),
                  CurvedSquare(
                    title: 'English',
                    channelId: 'UCLF6ZhuAuhOA98UwZgDkQ2Q',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

AppBar _buildAppbar({required BuildContext context}) {
  return AppBar(
    scrolledUnderElevation: 0,
    actions: [
      IconButton(
        icon: Icon(Icons.message_rounded),
        onPressed: () {
          Navigator.pushNamed(context, ChatScreen.routeName);
        },
      )
    ],
  );
}

class CurvedSquare extends StatelessWidget {
  final Widget? child;
  final String title;
  final String channelId;
  const CurvedSquare(
      {Key? key, this.child, required this.title, required this.channelId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return YoutubeScreen(
              query: title,
              channelId: channelId,
            );
          }));
        },
        child: Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.green[200],
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            title,
            style: TextStyle(
                color: whiteColor, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
    );
  }
}

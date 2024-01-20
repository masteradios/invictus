import 'package:flutter/material.dart';
import 'package:invictus/screens/auth/services/auth_services.dart';

import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';

class MyAccount extends StatefulWidget {
  static const routeName = '/account-page';
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetails();
  }

  void getUserDetails() async {
    setState(() {
      isLoading = true;
    });
    await AuthServices().getUserDetails(context: context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ModelUser _user = Provider.of<UserProvider>(context).user;
    return (isLoading)
        ? Center(
            child: const CircularProgressIndicator(
            color: greenColor,
          ))
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(100, 50),
              child: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: whiteColor,
                    )),
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [greenColor, Color.fromARGB(255, 29, 221, 163)],
                    ),
                  ),
                ),
                centerTitle: true,
                title: Text(
                  'Profile',
                  style: TextStyle(
                      color: whiteColor, fontSize: 30, letterSpacing: 1.1),
                ),
              ),
            ),
            body: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Material(
                      elevation: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              greenColor,
                              Color.fromARGB(255, 29, 221, 163)
                            ],
                          ),
                        ),
                        width: double.infinity,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 10),
                              child: CircleAvatar(
                                child: Icon(
                                  Icons.person_outline_outlined,
                                  size: 70,
                                ),
                                radius: 70,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                _user.username,
                                style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  BuildInfo(
                    icon: Icons.phone_outlined,
                    title: 'Phone',
                    subtitleText: _user.phoneNumber,
                  ),
                  BuildInfo(
                    icon: Icons.alternate_email_rounded,
                    title: 'Email',
                    subtitleText: _user.email,
                  ),
                  BuildInfo(
                    icon: Icons.location_city,
                    title: 'Address',
                    subtitleText: _user.address,
                  ),
                ],
              ),
            ),
          );
  }
}

class BuildInfo extends StatelessWidget {
  const BuildInfo(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitleText});

  final String title;
  final String subtitleText;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 35,
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 22),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subtitleText,
            maxLines: null,
            style: TextStyle(fontSize: 15),
          ),
          const Divider(
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:invictus/providers/user_provider.dart';
import 'package:invictus/screens/auth/services/auth_services.dart';
import 'package:invictus/screens/get_info/get_user_detail_page.dart';

import '../../constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/show_snackbar.dart';
import '../home/home_screen.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String res = 'not good';
  final _signupkey = GlobalKey<FormState>();
  final _signinkey = GlobalKey<FormState>();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();

  bool isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _namecontroller.dispose();
    _passwordcontroller.dispose();
    _phonecontroller.dispose();
  }

  void createUser() async {
    setState(() {
      isLoading = true;
    });
    res = await AuthServices().signUpUser(
        phoneNumber: int.parse(_phonecontroller.text.trim()),
        username: _namecontroller.text.trim(),
        email: _emailcontroller.text.trim(),
        password: _passwordcontroller.text.trim());

    setState(() {
      isLoading = false;
    });
    if (res ==
        "User created successfully.Please Sign-In with same credentials") {
      Navigator.pushReplacementNamed(context, GetUserDetails.routeName);
    } else {
      showSnackBar(context: context, content: res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 60),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Create Account',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Form(
                      key: _signupkey,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            CustomTextFormField(
                              keyboardType: TextInputType.name,
                              hintText: 'Enter your name',
                              controller: _namecontroller,
                            ),
                            CustomTextFormField(
                              keyboardType: TextInputType.emailAddress,
                              hintText: 'Enter your email',
                              controller: _emailcontroller,
                            ),
                            CustomTextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              hintText: 'Enter your password',
                              controller: _passwordcontroller,
                            ),
                            CustomTextFormField(
                              keyboardType: TextInputType.number,
                              hintText: 'Enter your phoneNumber',
                              controller: _phonecontroller,
                            ),
                            (isLoading)
                                ? Container(
                                    height: 48,
                                    margin: EdgeInsets.all(8),
                                    color: greenColor,
                                    width: double.infinity,
                                    child: Center(
                                      child: const CircularProgressIndicator(
                                        color: whiteColor,
                                      ),
                                    ),
                                  )
                                : CustomButton(
                                    buttontitle: 'Sign Up',
                                    callback: () {
                                      if (_signupkey.currentState!.validate()) {
                                        if (_passwordcontroller.text
                                                .trim()
                                                .length >=
                                            6) {
                                          createUser();
                                        } else {
                                          showSnackBar(
                                              context: context,
                                              content:
                                                  'Password must be of more than 6 characters');
                                        }
                                      }
                                    },
                                  )
                          ],
                        ),
                      )),
                ],
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  },
                  child: Text('Already a User?'))
            ],
          ),
        ),
      ),
    );
  }
}

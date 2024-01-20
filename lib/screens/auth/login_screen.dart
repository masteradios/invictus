import 'package:flutter/material.dart';
import 'package:invictus/screens/auth/services/auth_services.dart';

import '../../constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/show_snackbar.dart';
import '../home/home_screen.dart';
class LoginScreen extends StatefulWidget {
  static const routeName='/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _signinkey = GlobalKey<FormState>();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();

  bool isLoading = false;
  String res='';
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _namecontroller.dispose();
    _passwordcontroller.dispose();
    _phonecontroller.dispose();
  }
  void loginUser() async {
    setState(() {
      isLoading = true;
    });
    res = await AuthServices().loginUser(
        context: context,
        email: _emailcontroller.text.trim(),
        password: _passwordcontroller.text.trim());
    setState(() {
      isLoading = false;
    });
    if (res == 'Login Successful') {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } else {
      showSnackBar(context:context,content: res);    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView (
        child: Padding(
          padding: EdgeInsets.only(top: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Sign In',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  )
                ],
              ),
              Form(
                  key: _signinkey,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
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
                          buttontitle: 'Log in',
                          callback: () {
                            if (_signinkey.currentState!
                                .validate()) {
                              loginUser();
                              print('Login success!');
                            }
                          },
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

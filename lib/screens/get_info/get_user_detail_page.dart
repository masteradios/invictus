import 'package:flutter/material.dart';
import 'package:invictus/constants.dart';
import 'package:invictus/models/user.dart';
import 'package:invictus/providers/user_provider.dart';
import 'package:invictus/screens/auth/login_screen.dart';
import 'package:invictus/widgets/custom_button.dart';
import 'package:invictus/widgets/show_snackbar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:provider/provider.dart';
import '../auth/services/auth_services.dart';

int age = 0;
bool maleSelected = false;
bool femaleSelected = false;
Color maleColor = Colors.blue;
Color femaleColor = Colors.pink;
String selectedValue="General";
String familyIncome='';

class GetUserDetails extends StatefulWidget {
  static const routeName = '/get-user-details';
  GetUserDetails({super.key});

  @override
  State<GetUserDetails> createState() => _GetUserDetailsState();
}

class _GetUserDetailsState extends State<GetUserDetails> {
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Text(
              'Tell us About Yourself...',
              style: TextStyle(color: whiteColor, fontSize: 25),
            ),
            Expanded(
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: _controller,
                children: [Page1(), Page2()],
              ),
            ),
            SmoothPageIndicator(
              controller: _controller,
              count: 2,
              effect:
                  WormEffect(dotColor: whiteColor, activeDotColor: Colors.teal),
            ),
            CustomButton(
                callback: () async {
                  if (_controller.page == 0) {
                    if (age == 0) {
                      showSnackBar(
                          context: context,
                          content: 'Please select appropriate age');
                    } else if (maleSelected == false &&
                        femaleSelected == false) {
                      showSnackBar(
                          context: context, content: "Please select Gender ");
                      print(maleSelected);
                    } else {
                      String newData = (maleSelected) ? "male" : "female";
                      await AuthServices().upDateUserDetails(
                          context: context, key: "gender", newData: newData);
                      await AuthServices().upDateUserDetails(
                          context: context,
                          key: "age",
                          newData: age.toString());
                      _controller.nextPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn);
                    }
                  }
                  else if(_controller.page == 1)
                  {
                    if(familyIncome.isEmpty)
                    {
                      showSnackBar(context: context, content: "Enter your Family Income");
                    }else
                    {
                      await AuthServices().upDateUserDetails(
                          context: context, key: "caste", newData: selectedValue);
                      await AuthServices().upDateUserDetails(
                          context: context,
                          key: "family_income",
                          newData: familyIncome.toString());
                      Navigator.pushNamed(context, LoginScreen.routeName);

                    }
                  }
                },
                buttontitle: "Next")
          ],
        ),
      ),
    );
  }
}

class Page1 extends StatefulWidget {
  Page1({
    super.key,
  });

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  List<int> ageCategory = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: whiteColor,
        elevation: 5,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'You are a..',
                  style: TextStyle(color: greenColor, fontSize: 25),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (femaleSelected) {
                              femaleSelected = !femaleSelected;
                            }
                            maleSelected = !maleSelected;
                          });
                        },
                        child: Material(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          elevation: 5,
                          child: Container(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.male,
                                  color: Colors.black,
                                  size: 100,
                                ),
                                Text('Male'),
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: (maleSelected) ? maleColor : whiteColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (maleSelected) {
                              maleSelected = !maleSelected;
                            }
                            femaleSelected = !femaleSelected;
                          });
                        },
                        child: Material(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          elevation: 5,
                          child: Container(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.female,
                                  color: Colors.black,
                                  size: 100,
                                ),
                                Text('Female'),
                              ],
                            ),
                            decoration: BoxDecoration(
                              color:
                                  (femaleSelected) ? femaleColor : whiteColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Your age is ',
                      style: TextStyle(fontSize: 22),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          child: DropdownButton(
                        icon: Icon(Icons.arrow_drop_down),
                        value: age,
                        items: ageCategory.map((item) {
                          return DropdownMenuItem(
                            child: Text(item.toString()),
                            value: item,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            age = value!;
                          });
                        },
                      )),
                    ),
                    Text(
                      'Years',
                      style: TextStyle(fontSize: 22),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            width: 300,
            height: 550,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Please Select Your Category",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: 250,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                        labelText: 'Please Enter Your Caste',
                        enabledBorder: OutlineInputBorder()),
                    value: selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                    items: [
                      'General',
                      'EBC',
                      'SC',
                      'ST',
                      'OBC',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 20.0),
                // Text(
                //   'Selected Value: $selectedValue',
                //   style: TextStyle(fontSize: 16.0),
                // ),
                SizedBox(height: 20.0),
                Text(
                  "Enter Your Family Income",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15.0),
                Container(
                  width: 250.0,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        familyIncome = value;
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Family Income',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                    ),
                  ),
                ),
                // End of TextField for family income

                SizedBox(height: 20.0),

                // Displaying family income
                // Text(
                //   'Family Income: $familyIncome',
                //   style: TextStyle(fontSize: 16.0),
                // ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

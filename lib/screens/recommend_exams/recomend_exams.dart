import 'package:flutter/material.dart';
import 'package:invictus/constants.dart';
import 'package:invictus/models/user.dart';
import 'package:invictus/providers/user_provider.dart';
import 'package:invictus/screens/auth/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'API/ExamRecommendation_Api.dart'; // Replace with the actual import path

class ExamRecommendBody extends StatefulWidget {
  const ExamRecommendBody({Key? key}) : super(key: key);

  @override
  ExamRecommendBodyState createState() => ExamRecommendBodyState();
}

class ExamRecommendBodyState extends State<ExamRecommendBody> {
  List<String> examList = [];
  TextEditingController query1Controller = TextEditingController();
  TextEditingController query2Controller = TextEditingController();
  bool isLoading = false;

  Future<void> getExamList(String query1, String query2) async {
    setState(() {
      isLoading = true;
    });

    try {
      final result = await ExamRecommendationApi.getExamList(
          educationLevel: query1, age: query2);
      setState(() {
        examList = result;
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetails();
  }

  void getUserDetails() async {
    await AuthServices().getUserDetails(context: context);
  }

  @override
  Widget build(BuildContext context) {
    ModelUser _user = Provider.of<UserProvider>(context).user;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: query1Controller,
            decoration:
                InputDecoration(labelText: 'Enter The Education Level:'),
          ),
          SizedBox(height: 16),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              getExamList(query1Controller.text, _user.age);
            },
            child: Text('Get Exam List'),
          ),
          SizedBox(height: 16),
          if (isLoading)
            Container(
              height: 50, // Adjust the height as needed
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          else
            Text('Exam List:'),
          Expanded(
            child: !isLoading
                ? ListView.builder(
                    itemCount: examList.length,
                    itemBuilder: (context, index) {
                      return Container(child: Text(examList[index]));
                    },
                  )
                : SizedBox.shrink(), // Hide the ListView while loading
          ),
        ],
      ),
    );
  }
}

class ExamRecommend extends StatelessWidget {
  const ExamRecommend({Key? key}) : super(key: key);
  static const routeName = "/exam-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Exam Recommendation",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: greenColor,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
      ),
      backgroundColor: whiteColor,
      body: ExamRecommendBody(),
    );
  }
}

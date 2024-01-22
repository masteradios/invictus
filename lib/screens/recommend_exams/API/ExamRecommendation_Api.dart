import 'package:http/http.dart' as http;
import 'dart:convert';

class ExamRecommendationApi {
  static Future<List<String>> getExamList(
      {required String educationLevel,required String age}) async {
    final response = await http.get(
      Uri.parse('https://23e8-114-79-178-184.ngrok-free.app/get_exams_list?query1=$educationLevel&query2=$age'),
    );

    if (response.statusCode == 200) {
      print('Response Body: ${response.body}');

      // Parse the response JSON accordingly
      Map<String, dynamic> responseData = json.decode(response.body);
      List<dynamic> examsList = responseData['exams_list']['exams'];

      // Convert the dynamic list to a list of strings
      List<String> examNames = examsList.map((exam) => exam.toString()).toList();

      return examNames;
    } else {
      throw Exception('Failed to load exams list');
    }
  }
}


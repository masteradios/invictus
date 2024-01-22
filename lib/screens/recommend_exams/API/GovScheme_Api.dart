import 'package:http/http.dart' as http;
import 'dart:convert';
class GovSchemeApi {
  static Future<List<Map<String, dynamic>>> getRankedFiles(String query1, String query2) async {
    final response = await http.get(
      Uri.parse('https://23e8-114-79-178-184.ngrok-free.app/get_ranked_files?query1=$query1&query2=$query2'),
    );

    if (response.statusCode == 200) {
      // Parse the response JSON accordingly
      Map<String, dynamic> responseData = json.decode(response.body);

      // Extract the 'rank_list' object
      Map<String, dynamic> rankList = responseData['rank_list'];

      // Extract the 'schemename_obj' string from 'rank_list'
      String schemenameObjString = rankList['schemename_obj'];

      // Convert 'schemenameObjString' to a map
      Map<String, dynamic> schemenameObj = json.decode(schemenameObjString);

      // Extract the 'top_ranked_files' list directly from 'schemename_obj'
      List<dynamic> topRankedFiles = schemenameObj['top_ranked_files'];

      // Return the list of maps directly
      return topRankedFiles.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load ranked files');
    }
  }
}


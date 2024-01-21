import 'package:flutter/material.dart';
import 'package:invictus/constants.dart';
import '../recommend_exams/API/GovScheme_Api.dart';


class GovScheme_Recommend extends StatefulWidget {
  static const routeName = '/gov-scheme';
  const GovScheme_Recommend({super.key});

  @override
  _GovScheme_RecommendState createState() => _GovScheme_RecommendState();
}

class _GovScheme_RecommendState extends State<GovScheme_Recommend> {
  List<String> schemeList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchGovSchemes();
  }

  Future<void> fetchGovSchemes() async {
    try {
      List<Map<String, dynamic>> schemes =
          await GovSchemeApi.getRankedFiles('query1', 'query2');
      setState(() {
        schemeList = schemes.map((file) {
          String content = file['content'].toString();
          String schemeName = file['scheme_name'].toString();
          return '''
Scheme Name: $schemeName
Content: $content
''';
        }).toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching Gov Schemes: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: whiteColor,
            )),
        title: const Text(
          "Government Scheme",
          style: TextStyle(
            color: whiteColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: greenColor,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
          ),
        ),
      ),
      backgroundColor: whiteColor,
      body: Column(
        children: [
          Container(
            child: Text(""),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: schemeList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Text(schemeList[index]),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

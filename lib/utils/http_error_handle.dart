import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/show_snackbar.dart';

void httpErrorHandle({required http.Response res,required BuildContext context,required VoidCallback onSuccess})
{
  switch(res.statusCode)
  {
    case 200:
      onSuccess();
      break;
    case 500:
      showSnackBar(context: context, content: "Something went wrong");
    default:
      showSnackBar(context: context,content: jsonDecode(res.body)['message']);
      break;
  }
}
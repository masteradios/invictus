import 'package:flutter/material.dart';

showSnackBar({required BuildContext context,required String content}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        content,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 14),
      )));
}

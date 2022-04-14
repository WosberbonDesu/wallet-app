import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String message,Color colorTxt,
    {Color backgroundColor = const Color(0xff259625), int? lengthInSc}) {
  var snackBar = SnackBar(
    duration: Duration(seconds: lengthInSc ?? 4),
    behavior: SnackBarBehavior.floating,
    content: Text(
      message,
      style: TextStyle(color: colorTxt),
    ),
    backgroundColor: backgroundColor,
  );
  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
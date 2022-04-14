import 'package:flutter/material.dart';

import '../../../widgets/profilePageWidgets/profileBody.dart';


class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.only(top: 48.0),
        child: Body(),
      ),

    );
  }
}
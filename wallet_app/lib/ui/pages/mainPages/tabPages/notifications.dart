import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.network("https://assets6.lottiefiles.com/packages/lf20_heejrebm.json"));

  }
}

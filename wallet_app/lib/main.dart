import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:wallet_app/providers/AppState.dart';
import 'package:wallet_app/ui/pages/auth/login.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

/*
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'Important', // title
    description: 'N.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
 */



Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final AuthService _authService = AuthService(
      FirebaseAuth.instance,
      FirebaseFirestore.instance,
    );
    return MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (_) => AppState(authService: _authService))
      ],

      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',

        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),

        home:  Login(),

      ),
    );
  }
}

class AuthService  {
  final FirebaseAuth auth;
  final FirebaseFirestore firebase;

  AuthService(this.auth, this.firebase);



  }



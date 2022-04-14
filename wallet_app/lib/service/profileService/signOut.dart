import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class authServices{

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthService {

  Future<dynamic> login(String mail, String password);
  Future<dynamic> signUp(
      String mail, String password);
  Future<dynamic> forgotPassword(String mail);
  Future<dynamic> signOut(String uid);

}

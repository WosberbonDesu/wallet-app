import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
/*
class MyClass {
  MyClass(){}
  final auth = FirebaseAuth.instance;

  Future<DocumentSnapshot> getData() async {
    String uid = auth.currentUser!.uid!;
    var response=  await FirebaseFirestore.instance.collection("userthing").doc(uid).get();
    var userData = response.data();
    return userData;
  }

kdkdkdkd
 */

class GetUserName {
  final String documentId;

  GetUserName(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('userthing');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return data['userName'];
        }

        return Text("loading");
      },
    );
  }
}

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallet_app/business/constants/colors.dart';
import 'package:wallet_app/service/profileService/getUserData.dart';

import '../../../models/userModel.dart';
import '../../widgets/profilePageWidgets/displayImageWidget.dart';
import 'editImage.dart';
import 'editMailPage.dart';
import 'editNamePage.dart';
import 'editPhone.dart';


// This class handles the Page to dispaly the user's info on the "Edit Profile" Screen
class ProfilePage extends StatefulWidget {
  String email;
  String name;
  String phoneNum;
   ProfilePage({required this.email,required this.name,required this.phoneNum});

  @override
  _ProfilePageState createState() => _ProfilePageState();

}

class _ProfilePageState extends State<ProfilePage> {
  final auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;



  @override
  Widget build(BuildContext context) {

    //var userRef = _firestore.collection(uid);
    //final a = _firestore.collection(uid).doc('userName');
    CollectionReference users = FirebaseFirestore.instance.collection('userthing');
    String uid = auth.currentUser!.uid!;
    return Scaffold(
      body: FutureBuilder(
        future: users.doc(auth.currentUser!.uid!).get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if(snapshot.hasData){
            //final user = snapshot.data;
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

            return Column(
              children: [
                SizedBox(height: 70,),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);

                  },
                  child: Container(
                    color: Colors.redAccent,
                    height: 40,
                    child: Icon(Icons.arrow_back,color: Colors.white,),

                    width: 40,),
                ),
                const Center(
                    child:  Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(64, 105, 225, 1),
                          ),

                        ))),

                InkWell(
                    onTap: () {
                      navigateSecondPage(EditImagePage(imUrl: data["profileUrl"],));
                    },
                    child: DisplayImage(
                      imagePath: data["profileUrl"],
                      onPressed: () {},
                    )),
                buildUserInfoDisplay(data['userName'], 'Name', const EditNameFormPage()),
                buildUserInfoDisplay(data['phoneNum'], 'Phone', const EditPhoneFormPage()),
                buildUserInfoDisplay(data['userEmail'], 'Email', const EditEmailFormPage()),
                Expanded(
                  child: buildAbout("user"),
                  flex: 4,
                )
              ],
            );

          }else{
            return Center(child: CircularProgressIndicator());
          }

        }
      ),
    );

  }

  Stream<List<UserModel>> readUsers() => FirebaseFirestore.instance.collection(auth.currentUser!.uid!)
      .snapshots().map((snapshot) => snapshot.docs.map((doc) => UserModel.fromJson(doc.data()) ).toList());

  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
      Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                  width: 350,
                  height: 40,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom:  BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ))),
                  child: Row(children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              navigateSecondPage(editPage);
                            },
                            child: Text(
                              getValue,
                              style: const TextStyle(fontSize: 16, height: 1.4),
                            ))),
                    const Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey,
                      size: 40.0,
                    )
                  ]))
            ],
          ));

  // Widget builds the About Me Section
  Widget buildAbout(String user) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tell Us About Yourself',
            style:  TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 1),
          Container(
              width: 350,
              height: 200,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ))),
              child: Row(children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {

                        },
                        child: const Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child:  Text(
                                  "aboutMeDescription",
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 1.4,
                                  ),
                                ))))),
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                  size: 40.0,
                )
              ]))
        ],
      ));

  // Refrshes the Page after updating user info.
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  // Handles navigation and prompts refresh.
  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}


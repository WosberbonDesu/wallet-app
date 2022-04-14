import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallet_app/business/constants/colors.dart';
import 'package:wallet_app/business/styles/colors.dart';
import 'package:wallet_app/providers/AppState.dart';
import 'package:wallet_app/service/profileService/getUserData.dart';
import 'package:wallet_app/service/profileService/signOut.dart';
import 'package:wallet_app/ui/pages/profilePages/editProfilePage.dart';
import 'package:wallet_app/ui/widgets/error/showSnackbar.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('userthing');
    String uid = auth.currentUser!.uid!;

    return FutureBuilder<DocumentSnapshot>(
      
        future: users.doc(auth.currentUser!.uid!).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

          if (snapshot.connectionState == ConnectionState.done) {

            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                
                children: [
                  ProfilePic(firebaseImUrl: data["profileUrl"]),
                  SizedBox(height: 20),
                  ProfileMenu(
                    text: "My Account",
                    icon: Icons.account_circle,
                    colorIcon: PersonalColors.orange,
                    colorArrow: PersonalColors.orange,
                    textButtonColor: Colors.blueGrey,
                    press: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage(
                                    email: data['userEmail'],
                                    phoneNum: data['phoneNum'],
                                    name: data['userName'],
                                  )))
                    },
                  ),
                  ProfileMenu(
                    text: "Notifications",
                    icon: Icons.notification_important,
                    colorIcon: PersonalColors.orange,
                    colorArrow: PersonalColors.orange,
                    textButtonColor: Colors.blueGrey,
                    press: () {},
                  ),
                  ProfileMenu(
                    text: "Settings",
                    icon: Icons.android,
                    colorIcon: PersonalColors.orange,
                    colorArrow: PersonalColors.orange,
                    textButtonColor: Colors.blueGrey,
                    press: () {},
                  ),
                  ProfileMenu(
                    text: "Help Center",
                    icon: Icons.help,
                    colorIcon: PersonalColors.orange,
                    colorArrow: PersonalColors.orange,
                    textButtonColor: Colors.blueGrey,
                    press: () {},
                  ),
                  ProfileMenu(
                    text: "Log Out",
                    icon: Icons.exit_to_app,
                    colorIcon: Colors.white,
                    colorArrow: Colors.white,
                    textButtonColor: Colors.red,
                    press: () {},
                  ),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

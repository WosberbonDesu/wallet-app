import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

import '../../../business/styles/colors.dart';
import '../../../business/styles/text_styles.dart';
import '../../../business/styles/themes.dart';
import '../../../itlities/validators.dart';
import '../../widgets/error/showSnackbar.dart';
import '../../widgets/page_template.dart';
import '../../widgets/textfiledWidget.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController mailCtr = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  void dispose() {
    // TODO: implement dispose
    mailCtr.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AuthPageTemplate(
        page: Consumer(
          builder: (context, app, child) => Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Şifremi Unutttum",
                  style: PersonalTStyles.w700s24B,
                ),
                const SizedBox(height: 24),
                const Text(
                  "Şifre değişim linki için e-posta adresinizi giriniz.",
                ),
                const SizedBox(height: 40),
                buildTextField(
                    validator: (v) => validateMail(v),
                  iconData: FeatherIcons.mail,
                    controller: mailCtr,
                    text: "E-Posta"),
                const SizedBox(height: 40),
                TextButton(
                  onPressed: () async => await resetPassword(context),
                  child: const Text("E-Posta Gönder"),
                ),
                const SizedBox(height: 100),
                TextButton(
                    style: secondaryTextButtonTheme,
                    onPressed: () {Navigator.pop(context);},
                    child: const Text("Geri Dön")),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ));
  }

  Future<void> resetPassword(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: mailCtr.text.trim());
      showSnackBar(context,"Check your mail box",Colors.white);}
      on Exception catch(e){
        print(e);
        print("an error occured");
        showSnackBar(context, "Error occured", Colors.white,backgroundColor: Colors.redAccent);
      }
    }
      else {
        showSnackBar(context, "Error occured", Colors.white,backgroundColor: Colors.redAccent);
      }

  }
}
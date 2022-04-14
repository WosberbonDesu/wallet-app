import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet_app/business/constants/colors.dart';
import 'package:wallet_app/ui/pages/auth/forgot_password.dart';
import 'package:wallet_app/ui/pages/auth/signUp.dart';
import 'package:wallet_app/ui/pages/mainPages/mainTab.dart';
import '../../../business/styles/text_styles.dart';
import 'package:provider/provider.dart';
import '../../../itlities/validators.dart';
import '../../widgets/error/showSnackbar.dart';
import '../../widgets/page_template.dart';
import '../../widgets/textfiledWidget.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}


class _LoginState extends State<Login> {

  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController mailCtr = TextEditingController();
  final TextEditingController passCtr = TextEditingController();
  bool invisible = true;
  bool isLoading = false;
  changeLoading() => setState(() => isLoading = !isLoading);
@override
  void initState() {
    // TODO: implement initState
  mailCtr.text = "markow@gmail.com";
  passCtr.text = "123123123";
    super.initState();
  }
  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }


  @override
  Widget build(BuildContext context) {
    return AuthPageTemplate(
      page: buildLoginPage(context),
    );

  }

  buildLoginPage(BuildContext context) {

    return Consumer(
      builder: (context, app, child) =>
          Form(
            key: formKey,
            child: Column(

              children: [
                const Text(
                  "Giriş Yap",
                  style: PersonalTStyles.w700s24B,
                ),
                const SizedBox(height: 24),

                buildTextField(

                    iconData: Icons.mail,
                    validator: (v) => validateMail(v),
                    isObscure: false,
                    controller: mailCtr,
                    text: "E-Posta",

                ),

                const SizedBox(height: 20),

                GestureDetector(

                  child: buildTextField(

                      set: (){
                        invisible = !invisible;
                      },
                      iconData: FeatherIcons.eye,
                      validator: (v) => validatePassword(v),
                      isObscure: invisible,
                      controller: passCtr,
                      text: "Şifre"
                  ),
                ),

                const SizedBox(height: 24),
                isLoading
                    ? CircularProgressIndicator()
                    : Container(
                  width: 530,
                  child: TextButton(

                    onPressed: () async => await login(context),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: ColorConsts.mainOrange,
                      minimumSize: Size(10, 56),
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    child: Text("Giriş Yap",
                      style: GoogleFonts.inter(fontStyle: FontStyle.normal),),
                  ),
                ),
                const SizedBox(height: 25),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                  },
                  child: const Text(
                    "Şifreni mi Unuttun?",
                    textAlign: TextAlign.end,
                    style: PersonalTStyles.w600s14Or,
                  ),
                ),
                const SizedBox(height: 100),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Henüz bir hesabın yok mu?? ",
                    style: PersonalTStyles.w400s14G2,
                    children: [
                      TextSpan(
                        text: "Kaydol!",
                        style: PersonalTStyles.w600s14Or,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
    );

    void inContact(TapDownDetails details) {
      setState(() {
        invisible = false;
      });
    }
  }
  void Change(){
    setState(() { });
  }

  Future<void> login(BuildContext context) async {
    final auth = FirebaseAuth.instance;
    changeLoading();
    if (formKey.currentState!.validate()) {
      try{
        await auth.signInWithEmailAndPassword(email: mailCtr.text.trim(), password: passCtr.text.trim()).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => TabsScreen(userID: auth.currentUser!.uid))));
        
      }on Exception catch(e){
        showSnackBar(context, "Луфыд пасс вронг", Colors.white,backgroundColor: Colors.redAccent);
      }
      } // auth.createUserWithEmailAndPassword(email: _email, password: _password)
      else {
        print("auw");
      }
    changeLoading();
  }
}
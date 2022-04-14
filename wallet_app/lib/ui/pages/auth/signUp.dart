import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:wallet_app/itlities/validators.dart';
import 'package:wallet_app/ui/widgets/error/showSnackbar.dart';
import '../../../business/styles/colors.dart';
import '../../../business/styles/text_styles.dart';
import '../../widgets/page_template.dart';
import '../../widgets/textfiledWidget.dart';



class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}



class _SignupState extends State<Signup> {

  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController mailCtr = TextEditingController();
  final TextEditingController nameCtr = TextEditingController();
  final TextEditingController phoneCtr = TextEditingController();
  final TextEditingController passCtr = TextEditingController();
  final TextEditingController passAgainCtr = TextEditingController();
  UploadTask? uploadTask;

  CollectionReference userRef = FirebaseFirestore.instance.collection("userthing");

  bool isLoading = false;
  changeLoading() => setState(() => isLoading = !isLoading);
  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }
  PlatformFile? pickedFile;

  @override
  Widget build(BuildContext context) {

    return AuthPageTemplate(
        profilePicWidget: SizedBox(
            height: 120,
            width: 120,
            child: GestureDetector(
              onTap: () async => await profilePicture(context),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: PersonalColors.blue, width: 3),
                  color: PersonalColors.blue,
                  borderRadius: BorderRadius.circular(60),
                ),
                child: pickedFile != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Text(""),
                )
                    : const Icon(
                  FeatherIcons.users,
                  color: Colors.white,
                ),
              ),
            )),
        page: Consumer(
          builder: (context, app, child) => Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Kayıt Ol",
                  style: PersonalTStyles.w700s24B,
                ),
                const SizedBox(height: 24),
                buildTextField(
                    validator: (v) => validateEmptiness(v),
                    controller: nameCtr,
                    text: "İsim Soyisim"),
                const SizedBox(height: 20),
                buildTextField(
                    validator: (v) => validateMobile(v),
                    controller: phoneCtr,
                    text: "Telefon Numarası",
                    isPhoneNumber: true),
                const SizedBox(height: 20),
                buildTextField(
                    validator: (v) => validateMail(v),
                    controller: mailCtr,
                    text: "E-Posta"),
                const SizedBox(height: 20),
                buildTextField(
                    validator: (v) => validatePassword(v),
                    controller: passCtr,
                    isObscure: true,
                    text: "Şifre"),
                const SizedBox(height: 20),
                buildTextField(
                    validator: (v) => validatePassCheck(v,passCtr),
                    isObscure: true,
                    controller: passAgainCtr,
                    text: "Tekrar Şifre"),
                const SizedBox(height: 24),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : TextButton(
                  onPressed: () async => await signup(context),

                  child: const Text("Kayıt Ol"),
                ),
                const SizedBox(height: 100),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Zaten bir hesabınız var mı? ",
                    style: PersonalTStyles.w400s14G2,
                    children: [
                      TextSpan(
                        text: "Giriş Yap",
                        style: PersonalTStyles.w600s14Or,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {Navigator.pop(context);}
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ));
  }


  profilePicture(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 28.0),
          child: SizedBox(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                GestureDetector(
                    onTap: selectFile,
                    child: const Text("Galeriden Ekle")
                ),

                const Divider(),

                GestureDetector(

                    onTap: selectFile,
                    child: const Text("Fotoğraf Çek"),

                ),
                const Divider(),

              ],
            ),
          ),
        );
      },
    );

    }


  Future<void> signup(BuildContext context) async {
    final auth = FirebaseAuth.instance;
    String user;
    if (formKey.currentState!.validate()) {
      changeLoading();
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: mailCtr.text.trim(),
            password: passCtr.text.trim()
        );

        final snapshot = await uploadTask!.whenComplete(()  {});
        final urlDownload = await snapshot.ref.getDownloadURL();
        print("download urtl : $urlDownload");
        auth.currentUser!.uid;
        Map<String, dynamic> userData = {
          "userName": nameCtr.text,
          "userEmail": mailCtr.text,
          "phoneNum": phoneCtr.text,
          "profileUrl": urlDownload,
        };

        await userRef.doc(auth.currentUser!.uid).set(userData);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);

      }

    }
    else {
      print("An error occured");
    }
    changeLoading();
  }


  Future selectFile()async{
    final result = await FilePicker.platform.pickFiles();
    if(result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
    //final pickedFile = result.files.first;
    //openFile(pickedFile);

    uploadData();


  }


  void openFile(PlatformFile file){
    OpenFile.open(file.path!);
  }


  void uploadData()async {

    //UIhelper.showLoadingDialog(context, "Uploading image...");
    final path = 'profilepictures/${pickedFile!.name}';
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref()
        .child(path);

    uploadTask = ref.putFile(file);


    //TaskSnapshot snapshot = await uploadTask;

    //String? imageUrl = await snapshot.ref.getDownloadURL();
    //String? fullname = fullNameController.text.trim();


    //widget.userModel.profilepic = imageUrl;

    //await FirebaseFirestore.instance
    //.collection("users")
    //.doc(widget.userModel.uid)
    //.set(widget.userModel.toMap()).then((value) {
    //print("Data uploaded!");
    // });
  }
  }
/*
  Future<void> signup(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      changeLoading();
      var returnType = await app.authService.signUp(
          mailCtr.text.trim(),
          passCtr.text.trim(),
          UserModel(
            monthlyIncome: 0,
            monthlyOutcome: 0,
            uid: "",
            phoneNumber: num.parse(phoneCtr.text.trim()),
            email: mailCtr.text.trim(),
            name: nameCtr.text.trim(),
            createdAt: Timestamp.fromDate(DateTime.now()),
            lastLogin: Timestamp.fromDate(DateTime.now()),
            deviceList: [],
            notifyBudget: 0,
            currentBudget: 0,
          ),
          image);

      if (returnType is UserModel) {
        await app.setUser(returnType);
        navigatePushAndRemove(context, TabsScreen(userID: returnType.uid));
      } else {
        await showSnackBar(context, returnType,
            backgroundColor: PersonalColors.red);
      }
      changeLoading();
    }
  }

 */
/*
Map<String, dynamic> userData = {
                      "userName": nameCtr.text,
                      "password": passCtr.text,
                      "phoneNum": phoneCtr.text,

                    };

                    await userRef.doc("hZkPsHSWKKcRdVZ1").set(userData);
 */
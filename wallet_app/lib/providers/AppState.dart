import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallet_app/main.dart';
import 'package:wallet_app/ui/pages/auth/login.dart';
import '../business/contextGlobal.dart';
import '../business/styles/colors.dart';
import '../models/cardModel.dart';

import '../ui/widgets/error/showSnackbar.dart';


class AppState with ChangeNotifier {

  final AuthService? authService;

  AppState({

    required this.authService,

  }) {

  }

  double queryWidth =
      MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.width;

  double queryHeight =
      MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.height;
  String dateTime = "";

  dynamic notifications;

  addTransaction(num price, int type, DateTime date) async {

    notifyListeners();
  }

  Future getTransactions(String uid) async {

    try {
      List<TransactionModel> transactions = [];
      var transactionDocs = await FirebaseFirestore.instance
          .collection("cardCollection")
          .where("userUid", isEqualTo: auth.currentUser!.uid).get();
      print(transactionDocs.docs.map((e) => print(e)));
      if (transactionDocs.docs.isNotEmpty) {
        for (var item in transactionDocs.docs) {
          var transaction = TransactionModel.fromMap(item.data());
          transactions.add(transaction);
        }
      }
      notifyListeners();
      return transactions;

    } catch (e) {
      return "Bir hata oluştu. ${e.toString()}";
    }

  }



  Future getFexpense(String uid) async {

    try {
      List<TransactionModel> transactions = [];
      var transactionDocs = await FirebaseFirestore.instance
          .collection("cardCollection").where("isExpense",isEqualTo: false).where("userUid",isEqualTo: auth.currentUser?.uid).get();


      print(transactionDocs.docs.map((e) => print(e)));
      print(transactionDocs.docs.map((e) => print(e)));
      print(transactionDocs.docs.map((e) => print(e)));
      if (transactionDocs.docs.isNotEmpty) {
        for (var item in transactionDocs.docs) {
          var transaction = TransactionModel.fromMap(item.data());
          transactions.add(transaction);
        }
      }
      notifyListeners();
      return transactions;

    } catch (e) {
      return "Bir hata oluştu. ${e.toString()}";
    }

  }
  Future getExpense(String uid) async {

    try {
      List<TransactionModel> transactions = [];
      var transactionDocs = await FirebaseFirestore.instance
          .collection("cardCollection").where("isExpense",isEqualTo: true).where("userUid",isEqualTo: auth.currentUser?.uid).get();


      print(transactionDocs.docs.map((e) => print(e)));
      print(transactionDocs.docs.map((e) => print(e)));
      print(transactionDocs.docs.map((e) => print(e)));
      if (transactionDocs.docs.isNotEmpty) {
        for (var item in transactionDocs.docs) {
          var transaction = TransactionModel.fromMap(item.data());
          transactions.add(transaction);
        }
      }
      notifyListeners();
      return transactions;

    } catch (e) {
      return "Bir hata oluştu. ${e.toString()}";
    }

  }




  CollectionReference users = FirebaseFirestore.instance.collection('userthing');
  final auth = FirebaseAuth.instance;
  updateUser(String updatedName) {
    try{ users
        .doc(auth.currentUser!.uid)
        .update({'userName': updatedName})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
    }catch (e){
      showSnackBar(NavigationService.navigatorKey.currentContext!, "Hata çıktı", Colors.red);
    }
    notifyListeners();
  }
  /*
  Future getTransctions(String uid);

  getTransactions(String uidd) async {
    try {
      var returnType = await getTransctions(uidd);
      if (returnType is List<TransactionModel>) {
        user!.transactions = returnType;
      }
    } catch (e) {
      showSnackBar(NavigationService.navigatorKey.currentContext!,
          "Harcamalar alınamadı.",
          backgroundColor: PersonalColors.red);
    }
    notifyListeners();
  }
   */



  navigatePushAndRemove(BuildContext context, Widget page) {
    Navigator.pushAndRemoveUntil(context, createRoute(page), (route) => false);
  }

  signOut() async {
    try {
     await FirebaseAuth.instance.signOut().then((value) => navigatePushAndRemove(
         NavigationService.navigatorKey.currentContext!, const Login()));


    } catch (e) {
      showSnackBar(
          NavigationService.navigatorKey.currentContext!, "Çıkış Yapılamadı.",
          PersonalColors.red);
    }
    notifyListeners();
  }


  CardService(bool isExpense,String userUid,String dateTime,String category,String quantity)async{

    CollectionReference cardRef = FirebaseFirestore.instance.collection("cardCollection");



    //Iconda gelecek yada firestore dan yüklenip çekilecek boş bıraktım şimdilik

    try{

      Map<String, dynamic> cardData = {
        "dateTime": dateTime,
        "category": category,
        "quantity": quantity,
        "isExpense": isExpense,
        "userUid": userUid,
      };

      await cardRef.add(cardData);

    }catch (e){
      print("due to some problems in firebase unfortunalty send operation didn't work correctly");
    }
  }

}





Route createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.easeIn;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
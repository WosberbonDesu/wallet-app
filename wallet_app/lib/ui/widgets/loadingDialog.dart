import 'package:flutter/material.dart';


class UIhelper{
  static void showLoadingDialog(BuildContext context, String title){
    AlertDialog loadingDialog = AlertDialog(
      content: Container(

        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: Colors.black,
            ),
            SizedBox(height: 28,),
            Center(child: Text(title,style: TextStyle(fontWeight: FontWeight.bold),)),
          ],
        ),
      ),
    );
    showDialog(

        context: context,
        barrierColor: Colors.black,
        barrierDismissible: false,
        builder: (context){
          return loadingDialog;
        });
  }
}
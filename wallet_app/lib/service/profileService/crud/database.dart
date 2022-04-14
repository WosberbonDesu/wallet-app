import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wallet_app/ui/widgets/error/showSnackbar.dart';

import '../../../models/userModel.dart';

class Database{
  final auth = FirebaseAuth.instance;
  FirebaseFirestore? firestore;
  inialize(){

    firestore = FirebaseFirestore.instance;
  }


  /*
  Future<List<UserModel>> read()async{
    QuerySnapshot querySnapshot;
    List docs = [];
    try{
      querySnapshot = await firestore.collection("userthing").get();
      if(querySnapshot.docs.isNotEmpty){
        for(var doc in querySnapshot.docs.toList()){
          Map a = {"id": doc.id,"name":doc["name"],"code":doc["code"]};
          docs.add(a);
        }
        return docs;
      }
    }
    catch(e){
      print(e);
    }

  }
 */
  Stream<List<UserModel>> readUsers() => FirebaseFirestore.instance.collection(auth.currentUser!.uid!)
      .snapshots().map((snapshot) => snapshot.docs.map((doc) => UserModel.fromJson(doc.data()) ).toList());
}

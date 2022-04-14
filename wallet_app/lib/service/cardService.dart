import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:wallet_app/models/cardModel.dart';

class CardService{
  final auth = FirebaseAuth.instance;

  FirebaseFirestore? _instance;

  final List<TransactionModel> _cards = [];

  List<TransactionModel> getCardData(){

    return _cards;

  }




  //Future<void> getCardCollectionFromFirebase()async{

    //_instance = FirebaseFirestore.instance;

    //CollectionReference cardsS = FirebaseFirestore.instance.collection('cardCollection');

    //DocumentSnapshot snapshot = await cardsS.where()

    //var data = snapshot.data() as Map;
    //var cardDatas = data as List<dynamic>;
    
    //data.forEach((cardD) {

    //});


  //}

}
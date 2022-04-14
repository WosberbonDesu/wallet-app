import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_app/business/dateTimeConverter.dart';
import 'package:wallet_app/business/styles/colors.dart';
import 'package:wallet_app/models/cardModel.dart';
import 'package:wallet_app/ui/widgets/transactions/buildRowChartGraph.dart';
import '../../../../business/styles/text_styles.dart';
import '../../../../providers/AppState.dart';
import '../../../widgets/mainCardThing.dart';
import '../../../widgets/transactions/buildCardRowWidget.dart';
import '../../all_transactionPage.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  List<TransactionModel> cardDataTransaction = [];
  List<TransactionModel> cardDataFExpense = [];
  List<TransactionModel> cardDataExpense = [];
  var Fexpense = 0;
  var expense = 0;
  @override
  void initState() {
    // TODO: implement initState
    inisialize();
    super.initState();
  }

  void inisialize() async {
    var app = Provider.of<AppState>(context, listen: false);

    cardDataTransaction = await app.getTransactions(auth.currentUser!.uid);
    cardDataExpense = await app.getExpense(auth.currentUser!.uid);
    cardDataFExpense = await app.getFexpense(auth.currentUser!.uid);
    for (var i = 0; i < cardDataFExpense.length; i++) {
      Fexpense += int.parse(cardDataFExpense[i].quantity);
    }
    for (var i = 0; i < cardDataExpense.length; i++) {
      expense += int.parse(cardDataExpense[i].quantity);
    }
    print(cardDataTransaction);

    print("hiii");
  }

  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    CollectionReference cards =
        FirebaseFirestore.instance.collection('cardCollection');
    return Scaffold(
        body: Consumer<AppState>(
      builder: (context, app, child) => Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 45),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    "assets/top.png",
                    fit: BoxFit.fill,
                    height: 180,
                    width: 360,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  height: 132,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "Mevcut Bakiye",
                            style: PersonalTStyles.w500s12LB,
                          ),
                          Text(
                            "${Fexpense - expense} ₺",
                            style: PersonalTStyles.w600s24W,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          buildCardRowElement(
                              title: "Gelir (Bu Ay)",
                              price: Fexpense,
                              isExpense: false),
                          const SizedBox(width: 20),
                          buildCardRowElement(
                              title: "Gider (Bu Ay)",
                              price: expense,
                              isExpense: true),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 36),
            buildGraphLegend(),
            const Text(
              "Harcama Geçmişi",
              style: PersonalTStyles.w600s20B,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: cardDataTransaction.length,
                shrinkWrap: true,
                separatorBuilder: (_, __) => const SizedBox(height: 30),
                itemBuilder: (BuildContext context, int index) {
                  var transaction = 123;
                  return buildTransactionCard(
                      "assets/${cardDataTransaction[index].category.toLowerCase()}.png",
                      cardDataTransaction[index].category,
                      DateTimeConverter(cardDataTransaction[index].dateTime),
                      cardDataTransaction[index].isExpense == false
                          ? "+" + cardDataTransaction[index].quantity + "₺"
                          : "-" + cardDataTransaction[index].quantity + "₺",
                      cardDataTransaction[index].isExpense == false
                          ? Color(0xFF17D85C)
                          : Colors.black);
                },
              ),
            ),
            SizedBox(
              width: app.queryWidth - 48,
              child: TextButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: PersonalColors.orange)))),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllTransactions()));
                },
                child: const Text(
                  "Tümünü Gör",
                  style: TextStyle(color: PersonalColors.orange),
                ),
              ),
            ),
            const SizedBox(
              height: 36,
            ),
          ],
        ),
      ),
    ));
  }
}

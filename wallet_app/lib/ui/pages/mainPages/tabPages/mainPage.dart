import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:wallet_app/ui/pages/mainPages/spendAddScreen.dart';
import 'package:wallet_app/ui/widgets/error/showSnackbar.dart';
import '../../../../business/styles/colors.dart';
import '../../../../business/styles/text_styles.dart';
import '../../../../models/cardModel.dart';
import '../../../../providers/AppState.dart';


import 'package:provider/provider.dart';

import '../../../widgets/columnButton.dart';
import '../../../widgets/mainCardThing.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final auth = FirebaseAuth.instance;
  List<TransactionModel> cardDataTransaction = [];
  List<TransactionModel> cardDataAmaExpense = [];
  List<TransactionModel> cardDataAmaFexpense = [];
  var sum = 0;
  var Fexpense = 0;
  var expense = 0;
  @override
  void initState() {

    // TODO: implement initState

    inisialize();
    super.initState();

  }
  void inisialize()async{

    var app = Provider.of<AppState>(context, listen: false);

    cardDataTransaction= await app.getTransactions(auth.currentUser!.uid);

    cardDataAmaExpense = await app.getFexpense(auth.currentUser!.uid);
    cardDataAmaFexpense = await app.getExpense(auth.currentUser!.uid);
    for (var i = 0; i < cardDataAmaFexpense.length; i++) {

      Fexpense += int.parse(cardDataAmaFexpense[i].quantity);
    }
    for (var i = 0; i < cardDataAmaExpense.length; i++) {

      expense += int.parse(cardDataAmaExpense[i].quantity);
    }
    /*
    for (var i = 0; i < cardDataAmaExpense.length; i++) {

      sum += int.parse(cardDataAmaExpense[i].quantity);
    }
     */


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AppState>(
        builder: (context, app, child) => Stack(
          clipBehavior: Clip.none,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Image.network(
                  "https://images.unsplash.com/photo-1550353127-b0da3aeaa0ca?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2071&q=80",
                  fit: BoxFit.fill,

                ),
                Positioned(
                  top: 60,
                  left: 20,
                  right: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          Text(
                            "Mevcut Durumunuz",
                            style: PersonalTStyles.w500s16W,
                          ),
                          SizedBox(height: 5),
                          Text(
                            "${expense-Fexpense} ₺",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            )
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: (){

                          showSnackBar(context, "No notification found", Colors.white,backgroundColor: Colors.redAccent);
                        },
                        icon: const Icon(
                          FeatherIcons.bell,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: -50,
                  right: 20,
                  left: 20,
                  child: Container(
                    height: 100,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildColButton(
                            color: PersonalColors.orange,
                            title: "Harcama Gir",
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>AddInvoice(backgroundColor: Color(0xFFFF9900), title: "title", isExpense: false))
                              );},
                            icon: FeatherIcons.plus),
                        buildColButton(
                            color: PersonalColors.purple,
                           title: "Borç Gir",
                            onTap: () {
                              showSnackBar(context, "Üzgünüz bu safya mevcut değil", Colors.black,backgroundColor: Colors.white);
                            },
                           icon: FeatherIcons.arrowUp),
                        buildColButton(
                            color: PersonalColors.softRed,
                            title: "Gelen Gir",

                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>AddInvoice(backgroundColor: Color(0xFFFF6854), title: "title", isExpense: true)));

                            },
                            icon: FeatherIcons.arrowDown),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top:  app.queryHeight * 0.25 + 100),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:  [

                    Text(
                      "Son Harcamalar",
                      style: TextStyle(color: Colors.white),
                    ),

                    //Datetime gelicek beilerr huii BLYT hahah blyt huhuhu bababababa hahaaa

                    cardDataTransaction.isNotEmpty ?

                      Expanded(
                        child: ListView.separated(
                          itemCount:cardDataTransaction.length,
                          shrinkWrap: true,
                          separatorBuilder: (_, __) => const SizedBox(height: 30),
                          itemBuilder: (BuildContext context, int index) {
                            //cardDataTransaction.forEach((element) {print(int.parse(element.quantity));});

                            var transaction = 123;
                            return buildTransactionCard("assets/${cardDataTransaction[index].category.toLowerCase()}.png",cardDataTransaction[index].category,cardDataTransaction[index].dateTime.toString(),
                                cardDataTransaction[index].isExpense == false ?
                                "+" + cardDataTransaction[index].quantity+"₺" : "-" + cardDataTransaction[index].quantity+"₺",cardDataTransaction[index].isExpense == false ? Color(0xFF17D85C) : Colors.black);
                          },


                        ),
                      ):
                    Expanded(
                      child: Center(
                        child: Text("Harcamanız bulunmuyor."),
                      )
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

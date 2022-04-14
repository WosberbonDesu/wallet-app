import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../business/styles/colors.dart';
import '../../../business/styles/text_styles.dart';
import '../../../models/categoryModelAddScrn.dart';
import '../../../models/choiceChipData.dart';
import '../../../models/data/choiceChipDatas.dart';
import '../../../providers/AppState.dart';

class AddInvoice extends StatefulWidget {
  const AddInvoice({
    Key? key,
    required this.backgroundColor,
    required this.title,
    required this.isExpense,
  }) : super(key: key);

  final Color backgroundColor;
  final String title;
  final bool isExpense;

  @override
  _AddInvoiceState createState() => _AddInvoiceState();
}

class _AddInvoiceState extends State<AddInvoice> {
  final auth = FirebaseAuth.instance;
  bool _isSelected = false;
  final double spacing = 8;
  int intValue = 0;
  int decimalValue = 00;
  DateTime transactionDate = DateTime.now();
  bool switchDesimal = false;
  bool isLoading = false;
  changeLoading() => setState(() => isLoading = !isLoading);
  bool isSending = false;
  changeSendLoading() => setState(() => isSending = !isSending);
  List<CategoryModel> categories = [];
  CategoryModel? selectedCategory;
  List<ChoiceChipData> choiceChips = ChoiceChips.all;
  String choiceShipL = "";
  String formattedDate = "";

  @override
  void initState() {
    initialize();

    super.initState();
  }

  initialize() async {
    changeLoading();
    var app = Provider.of<AppState>(context, listen: false);



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,    appBar: AppBar(
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: widget.backgroundColor,
        centerTitle: true,
        title: Text(
          "Harcama Gir",
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body:Consumer<AppState>(
        builder: (context, app, child) => SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                  height: app.queryHeight * 0.3,
                  child: Container(
                    color: widget.backgroundColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("₺ Cinsinden Harcamanız:",
                              style: TextStyle(color: Colors.white),)
                          ],
                        ),
                        Text(
                          "$intValue" "." "$decimalValue" " ₺",
                          style: PersonalTStyles.w600s32W,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: 300,
                          height: 75,
                          child: CupertinoTheme(
                            data: const CupertinoThemeData(
                                textTheme: CupertinoTextThemeData(
                                    dateTimePickerTextStyle:
                                    PersonalTStyles.w600s24W)),
                            child: buildChoiceChips(),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 24, bottom: 24, right: 24),
                          height: 40,
                          width: app.queryWidth,
                          child: ListView.separated(
                            itemCount: categories.length,
                            shrinkWrap: true,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                            const SizedBox(
                              width: 12,
                            ),
                            scrollDirection: Axis.horizontal,
                            itemBuilder:
                                (BuildContext context, int index) =>
                                tagItem(
                                  category: categories[index],
                                  onTap: () => setState(() =>
                                  selectedCategory = categories[index]),
                                ),
                          ),
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                  height: app.queryHeight * 0.6,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NumpadItem(
                            numpadValue: "1",
                            onPressed: () => writeNumber("1"),
                          ),
                          NumpadItem(
                            numpadValue: "2",
                            onPressed: () => writeNumber("2"),
                          ),
                          NumpadItem(
                            numpadValue: "3",
                            onPressed: () => writeNumber("3"),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NumpadItem(
                            numpadValue: "4",
                            onPressed: () => writeNumber("4"),
                          ),
                          NumpadItem(
                            numpadValue: "5",
                            onPressed: () => writeNumber("5"),
                          ),
                          NumpadItem(
                            numpadValue: "6",
                            onPressed: () => writeNumber("6"),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NumpadItem(
                            numpadValue: "7",
                            onPressed: () => writeNumber("7"),
                          ),
                          NumpadItem(
                            numpadValue: "8",
                            onPressed: () => writeNumber("8"),
                          ),
                          NumpadItem(
                            numpadValue: "9",
                            onPressed: () => writeNumber("9"),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: const EdgeInsets.all(16),
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFFD7D7D7)),
                                  borderRadius:
                                  BorderRadius.circular(16)),
                              child: InkWell(
                                onTap: () => setState(
                                        () => switchDesimal = !switchDesimal),
                                child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(16),
                                    child: const Center(
                                      child: Text("."),
                                    )),
                              )),
                          NumpadItem(
                            numpadValue: "0",
                            onPressed: () => writeNumber("0"),
                          ),
                          Container(
                              margin: const EdgeInsets.all(16),
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFFD7D7D7)),
                                  borderRadius:
                                  BorderRadius.circular(16)),
                              child: InkWell(
                                onTap: () {
                                  onBackspaceTapped();
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: const Center(
                                      child: Icon(Icons.backspace)),
                                ),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      isSending
                          ? CircularProgressIndicator(
                        color: widget.backgroundColor,
                      )
                          : SizedBox(
                        width: app.queryWidth - 40,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: intValue != 0 ? Colors.white:  Color(0xFFB5B5B5),
                            backgroundColor: intValue != 0 ? PersonalColors.orange:  Color(0xFFF2F2F2),
                          ),
                          onPressed: (){
                            formattedDate = DateFormat('yyyy-MM-dd').format(transactionDate);
                            app.CardService(
                                widget.isExpense,
                                auth.currentUser!.uid,
                                formattedDate,
                                choiceShipL,
                                intValue.toString());
                          },
                          child:  Text("Devam et"),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void onBackspaceTapped() {
    setState(() {
      if (switchDesimal == false) {
        if (intValue.toString().length == 1) {
          intValue = 0;
        } else {
          final String intValueString;
          intValueString =
              intValue.toString().substring(0, intValue.toString().length - 1);
          intValue = int.parse(intValueString);
        }
      } else {
        if (decimalValue.toString().length == 1) {
          decimalValue = 0;
          switchDesimal = false;
        } else {
          final String decimalValueString;
          decimalValueString = decimalValue
              .toString()
              .substring(0, decimalValue.toString().length - 1);
          decimalValue = int.parse(decimalValueString);
        }
      }
    });
  }
  Widget buildChoiceChips() => ListView(

    physics: BouncingScrollPhysics(),
   itemExtent: 75,
    scrollDirection: Axis.horizontal,
    children: choiceChips
        .map((choiceChip) => ChoiceChip(
      label: Text(choiceChip.label!),
      labelStyle: TextStyle(
          fontWeight: FontWeight.bold, color: Colors.white),
      onSelected: (isSelected) => setState(() {
        choiceChips = choiceChips.map((otherChip) {
          final newChip = otherChip.copy(isSelected: false);

          return choiceChip == newChip
              ? newChip.copy(isSelected: isSelected)
              : newChip;
        }).toList();

        choiceShipL = choiceChip.label!;
        print(choiceShipL);
        print(transactionDate);


      }),
      selected: choiceChip.isSelected!,
      selectedColor: Colors.black,
      backgroundColor: Colors.deepPurple.shade300,
    ))
        .toList(),
  );
  void writeNumber(String selectedNumber) {
    setState(() {
      if (switchDesimal == false) {
        intValue = int.parse(intValue.toString() + selectedNumber);
      } else {
        if (decimalValue.toString().length < 2) {
          decimalValue = int.parse(decimalValue.toString() + selectedNumber);
        }
      }
    });
  }

  tagItem({required CategoryModel category, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            color: selectedCategory == category
                ? Colors.white
                : const Color(0x1AFFFFFF),
            borderRadius: BorderRadius.circular(100)),
        child: Center(
          child: Text(category.title,
              style: selectedCategory == category
                  ? PersonalTStyles.w600s14Or
                  .copyWith(color: widget.backgroundColor)
                  : PersonalTStyles.w600s14W),
        ),
      ),
    );
  }
}

class NumpadItem extends StatelessWidget {
  final Function() onPressed;
  final String numpadValue;
  const NumpadItem({
    Key? key,
    required this.onPressed,
    required this.numpadValue,
  }) : super(key: key);

  // The object above this will be co

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(16),
        width: 64,
        height: 64,
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFD7D7D7)),
            borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          onTap: onPressed,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Center(
              child: Text(numpadValue,style: TextStyle(color: Colors.black,fontSize: 20),),
            ),
          ),
        ));
  }
}
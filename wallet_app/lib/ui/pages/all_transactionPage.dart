import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart';
import 'package:wallet_app/business/dateTimeConverter.dart';
import 'package:wallet_app/itlities/DataHelpers.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../../business/constants/sort_enums.dart';
import '../../business/styles/text_styles.dart';
import '../../models/cardModel.dart';
import '../../providers/AppState.dart';
import '../widgets/mainCardThing.dart';
import '../widgets/sortingRot.dart';

class AllTransactions extends StatefulWidget {
  const AllTransactions({Key? key}) : super(key: key);

  @override
  _AllTransactionsState createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  final auth = FirebaseAuth.instance;
  List<TransactionModel> cardDataTransaction = [];
  List<TransactionModel> cardDataChanges = [];
  int index = 1;
  SortEnums sortValue = SortEnums.all;
  dynamic defaultTransactions, filteredTransactions;
  bool isLoading = false;
  changeLoading() => setState(() => isLoading = !isLoading);
  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    changeLoading();
    var app = Provider.of<AppState>(context, listen: false);
    defaultTransactions =
        filteredTransactions = await app.getTransactions(auth.currentUser!.uid);
    cardDataTransaction = await app.getTransactions(auth.currentUser!.uid);
    print("Buranın altında aga");
    print(defaultTransactions);
    print("Buranın üstünde aga");
    cardDataChanges = cardDataTransaction;
    changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        title: const Text(
          "Harcamalar",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () async => await filterFunction(context),
              icon: const Icon(CupertinoIcons.slider_horizontal_3))
        ],
      ),
      body: Consumer<AppState>(
        builder: (context, app, child) {
          filteredTransactions = filterTransactions();
          return Column(
            children: [
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () =>
                        setState(() => cardDataChanges = cardDataTransaction),
                    child: const Text("Tüm İşlemler"),
                  ),
                  TextButton(
                    onPressed: () => setState(() => cardDataChanges =
                        cardDataTransaction
                            .where((e) => (e.isExpense == true))
                            .toList()),
                    child: const Text("Gelir"),
                  ),
                  TextButton(
                    onPressed: () => setState(() => cardDataChanges =
                        cardDataTransaction
                            .where((e) => (e.isExpense == false))
                            .toList()),
                    child: const Text("Gider"),
                  )
                ],
              ),
              Expanded(
                child: (cardDataTransaction == null ||
                        cardDataTransaction.isEmpty)
                    ? const Center(
                        child: Text("Harcamanız bulunmuyor."),
                      )
                    : GroupedListView<TransactionModel, String>(
                        elements: cardDataChanges,
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 24),
                        groupBy: (elemnt) => elemnt.dateTime,
                        shrinkWrap: true,
                        order: GroupedListOrder.DESC,
                        groupSeparatorBuilder: (value) => Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Text(
                            DateTime.parse(value).isToday()
                                ? "Bugün"
                                : DateTime.parse(value).isYesterday()
                                    ? "Dün"
                                    : DateFormat('d.MM.yyyy')
                                        .format(DateTime.parse(value)),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        itemBuilder: (context, TransactionModel model) {
                          print("transaction");
                          print("transaction");

                          return buildTransactionCard(
                              "assets/${model.category.toLowerCase()}.png",
                              model.category,
                              DateTimeConverter(model.dateTime),
                              model.isExpense == false
                                  ? "+" + model.quantity + "₺"
                                  : "-" + model.quantity + "₺",
                              model.isExpense == false
                                  ? Color(0xFF17D85C)
                                  : Colors.black);
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<dynamic> filterFunction(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(28.0),
          child: SizedBox(
            height: 250,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Filtrele",
                    style: PersonalTStyles.w600s20B,
                  ),
                  const SizedBox(height: 28),
                  GestureDetector(
                    onTap: () {
                      setState(
                        () => sortValue = SortEnums.all,
                      );

                      Navigator.pop(context);
                    },
                    child: buildSortingRow(
                      value: SortEnums.all,
                      sortValue: sortValue,
                    ),
                  ),
                  const Divider(),
                  GestureDetector(
                    onTap: () {
                      setState(
                        () => sortValue = SortEnums.thisWeek,
                      );

                      Navigator.pop(context);
                    },
                    child: buildSortingRow(
                      value: SortEnums.thisWeek,
                      sortValue: sortValue,
                    ),
                  ),
                  const Divider(),
                  GestureDetector(
                    onTap: () {
                      setState(
                        () => sortValue = SortEnums.thisMonth,
                      );

                      Navigator.pop(context);
                    },
                    child: buildSortingRow(
                        value: SortEnums.thisMonth, sortValue: sortValue),
                  ),
                  const Divider(),
                  GestureDetector(
                    onTap: () {
                      setState(
                        () => sortValue = SortEnums.lastThreeMonths,
                      );

                      Navigator.pop(context);
                    },
                    child: buildSortingRow(
                        value: SortEnums.lastThreeMonths, sortValue: sortValue),
                  ),
                  const Divider(),
                  GestureDetector(
                    onTap: () {
                      setState(
                        () => sortValue = SortEnums.thisYear,
                      );

                      Navigator.pop(context);
                    },
                    child: buildSortingRow(
                        value: SortEnums.thisYear, sortValue: sortValue),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  filterTransactions() {
    if (defaultTransactions is List<TransactionModel>) {
      final date = DateTime.now();
      if (index == 1) {
        return filterBySorting(date, defaultTransactions);
      } else if (index == 2) {
        return filterBySorting(
            date,
            (defaultTransactions as List<TransactionModel>)
                .where((element) => element.isExpense == false)
                .toList());
      } else {
        return filterBySorting(
            date,
            (defaultTransactions as List<TransactionModel>)
                .where((element) => element.isExpense == true)
                .toList());
      }
    } else {
      return defaultTransactions;
    }
  }

  filterBySorting(DateTime date, List<TransactionModel> defaultTransactions) {
    if (sortValue == SortEnums.all) {
      return defaultTransactions;
    } else if (sortValue == SortEnums.thisWeek) {
      return (defaultTransactions)
          .where((element) =>
              DateTime.fromMillisecondsSinceEpoch(int.parse(element.dateTime))
                  .compareTo(date.subtract(Duration(days: date.weekday - 1))) >=
              0)
          .toList();
    } else if (sortValue == SortEnums.thisMonth) {
      return (defaultTransactions)
          .where((element) => ((DateTime.fromMillisecondsSinceEpoch(
                          int.parse(element.dateTime))
                      .month ==
                  date.month) &&
              (DateTime.fromMillisecondsSinceEpoch(int.parse(element.dateTime))
                      .year ==
                  date.year)))
          .toList();
    } else if (sortValue == SortEnums.lastThreeMonths) {
      return (defaultTransactions)
          .where((element) => ((DateTime.fromMillisecondsSinceEpoch(
                          int.parse(element.dateTime))
                      .year ==
                  date.year) &&
              DateTime.fromMillisecondsSinceEpoch(int.parse(element.dateTime))
                      .month >=
                  date.month - 3))
          .toList();
    } else {
      return (defaultTransactions)
          .where((element) =>
              (DateTime.fromMillisecondsSinceEpoch(int.parse(element.dateTime))
                      .year ==
                  date.year))
          .toList();
    }
  }
}

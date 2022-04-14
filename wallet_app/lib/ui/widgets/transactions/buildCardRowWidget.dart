import 'package:flutter/material.dart';

import '../../../business/styles/text_styles.dart';


Expanded buildCardRowElement(
    {required String title, required num price, required bool isExpense}) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: PersonalTStyles.w500s12G1,
          ),
          Text(
            (isExpense ? "-" : "+") +
                " ${price.toStringAsFixed(2).replaceAll(".", ",")} ₺",
            style: isExpense
                ? PersonalTStyles.w600s14SR
                : PersonalTStyles.w600s14G,
          )
        ],
      ),
    ),
  );
}